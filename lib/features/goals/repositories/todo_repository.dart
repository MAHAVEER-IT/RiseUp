import 'package:isar/isar.dart';
import '../models/todo.dart';

class TodoRepository {
  final Isar isar;

  TodoRepository(this.isar);

  Future<void> saveTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  Future<Todo?> getTodoById(int id) async {
    return await isar.todos.get(id);
  }

  Future<List<Todo>> getActiveTodos() async {
    return await isar.todos
        .filter()
        .isCompletedEqualTo(false)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<List<Todo>> getAllTodos() async {
    return await isar.todos.where().sortByCreatedAtDesc().findAll();
  }

  Future<int> getCompletedTodosCountLastDays(int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    return await isar.todos
        .filter()
        .isCompletedEqualTo(true)
        .createdAtGreaterThan(startDate)
        .count();
  }

  Future<void> toggleTodo(int id) async {
    await isar.writeTxn(() async {
      final todo = await isar.todos.get(id);
      if (todo != null) {
        todo.isCompleted = !todo.isCompleted;
        // If parent task is completed, also mark all sub-tasks completed
        if (todo.isCompleted) {
          for (var sub in todo.subTodos) {
            sub.isCompleted = true;
          }
        }
        await isar.todos.put(todo);
      }
    });
  }

  Future<void> toggleSubTodo(int id, int subIndex) async {
    await isar.writeTxn(() async {
      final todo = await isar.todos.get(id);
      if (todo != null && subIndex >= 0 && subIndex < todo.subTodos.length) {
        todo.subTodos[subIndex].isCompleted = !todo.subTodos[subIndex].isCompleted;
        
        // If all sub-todos are completed, auto-complete parent todo (optional, but let's keep it manual or simple)
        // Check if all are completed:
        final allDone = todo.subTodos.every((sub) => sub.isCompleted);
        if (allDone) {
          todo.isCompleted = true;
        } else {
          todo.isCompleted = false; // Uncheck parent if a subtask is unchecked
        }

        await isar.todos.put(todo);
      }
    });
  }

  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
  }
}
