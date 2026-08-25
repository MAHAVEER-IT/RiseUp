import 'package:isar/isar.dart';

part 'reflection.g.dart';

@collection
class Reflection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  late String content;
  late String smallWin;

  late DateTime createdAt;
}
