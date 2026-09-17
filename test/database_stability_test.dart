import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:riseup/features/goals/models/todo.dart';
import 'package:riseup/features/goals/repositories/todo_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('To-do database stability', () {
    late Directory databaseDirectory;
    late Isar isar;

    setUp(() async {
      databaseDirectory = await Directory.systemTemp.createTemp(
        'riseup_database_test_',
      );
      isar = await Isar.open(
        [TodoSchema],
        name: 'todo_stability',
        directory: databaseDirectory.path,
      );
    });

    tearDown(() async {
      await isar.close(deleteFromDisk: true);
      if (await databaseDirectory.exists()) {
        await databaseDirectory.delete(recursive: true);
      }
    });

    test('persists a saved to-do after reopening the database', () async {
      final repository = TodoRepository(isar);
      final todo = Todo()
        ..title = 'Finish database test'
        ..isCompleted = false
        ..createdAt = DateTime(2026, 9, 16, 10)
        ..dueTime = DateTime(2026, 9, 16, 21, 30)
        ..subTodos = [SubTodo(title: 'Write', isCompleted: false)];

      await repository.saveTodo(todo);
      final savedId = todo.id;

      await isar.close();
      isar = await Isar.open(
        [TodoSchema],
        name: 'todo_stability',
        directory: databaseDirectory.path,
      );

      final reopened = await TodoRepository(isar).getTodoById(savedId);
      expect(reopened, isNotNull);
      expect(reopened!.title, 'Finish database test');
      expect(reopened.dueTime, DateTime(2026, 9, 16, 21, 30));
      expect(reopened.subTodos.single.title, 'Write');
    });

    test('updates completion state and removes only the requested to-do',
        () async {
      final repository = TodoRepository(isar);
      final first = Todo()
        ..title = 'First'
        ..isCompleted = false
        ..createdAt = DateTime.now()
        ..subTodos = [];
      final second = Todo()
        ..title = 'Second'
        ..isCompleted = false
        ..createdAt = DateTime.now()
        ..subTodos = [];

      await repository.saveTodo(first);
      await repository.saveTodo(second);
      await repository.toggleTodo(first.id);

      expect((await repository.getTodoById(first.id))!.isCompleted, isTrue);
      await repository.deleteTodo(first.id);

      expect(await repository.getTodoById(first.id), isNull);
      expect((await repository.getTodoById(second.id))!.title, 'Second');
    });
  });
}
