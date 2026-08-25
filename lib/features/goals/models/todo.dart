import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;

  late String title;

  late bool isCompleted;

  late DateTime createdAt;

  DateTime? dueTime;

  List<SubTodo> subTodos = [];
}

@embedded
class SubTodo {
  String? title;
  bool isCompleted = false;

  SubTodo({this.title, this.isCompleted = false});
}
