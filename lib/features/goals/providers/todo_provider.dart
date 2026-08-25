import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/core/notifications/notification_service.dart';
import '../models/todo.dart';
import '../repositories/todo_repository.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return TodoRepository(isar);
});

final activeTodosProvider =
    AsyncNotifierProvider<ActiveTodosNotifier, List<Todo>>(() {
      return ActiveTodosNotifier();
    });

class ActiveTodosNotifier extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    return ref.watch(todoRepositoryProvider).getActiveTodos();
  }

  Future<void> addTodo(String title, DateTime? dueTime, List<String> subTasks) async {
    final newTodo = Todo()
      ..title = title
      ..isCompleted = false
      ..createdAt = DateTime.now()
      ..dueTime = dueTime
      ..subTodos = subTasks.map((subTitle) => SubTodo(title: subTitle, isCompleted: false)).toList();

    await ref.read(todoRepositoryProvider).saveTodo(newTodo);
    await NotificationService.scheduleTodoNotification(newTodo);
    state = await AsyncValue.guard(() => build());
  }

  Future<void> updateTodo({
    required int id,
    required String title,
    required DateTime? dueTime,
    required List<SubTodo> subTodos,
  }) async {
    final repository = ref.read(todoRepositoryProvider);
    final existing = await repository.getTodoById(id);
    if (existing != null) {
      await NotificationService.cancelTodoNotification(id);
      existing.title = title;
      existing.dueTime = dueTime;
      existing.subTodos = subTodos;
      if (subTodos.isNotEmpty) {
        existing.isCompleted = subTodos.every((s) => s.isCompleted);
      }
      await repository.saveTodo(existing);
      await NotificationService.scheduleTodoNotification(existing);
      state = await AsyncValue.guard(() => build());
    }
  }

  Future<void> toggleTodo(int id) async {
    await ref.read(todoRepositoryProvider).toggleTodo(id);
    state = await AsyncValue.guard(() => build());
  }

  Future<void> toggleSubTodo(int id, int subIndex) async {
    await ref.read(todoRepositoryProvider).toggleSubTodo(id, subIndex);
    state = await AsyncValue.guard(() => build());
  }

  Future<void> deleteTodo(int id) async {
    await NotificationService.cancelTodoNotification(id);
    await ref.read(todoRepositoryProvider).deleteTodo(id);
    state = await AsyncValue.guard(() => build());
  }
}
