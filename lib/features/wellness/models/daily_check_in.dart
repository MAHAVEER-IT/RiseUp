import 'package:isar/isar.dart';

part 'daily_check_in.g.dart';

@collection
class DailyCheckIn {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  late bool morningCompleted;
  late bool eveningCompleted;

  late byte moodScore;
  late byte energyScore;

  String? eveningReflection;
}
