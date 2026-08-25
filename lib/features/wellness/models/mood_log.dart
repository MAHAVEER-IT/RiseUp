import 'package:isar/isar.dart';

part 'mood_log.g.dart';

@collection
class MoodLog {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime timestamp;

  late byte moodScore; // 1-5
  late byte energyScore; // 1-5: Very Low to Excellent

  String? note;
}
