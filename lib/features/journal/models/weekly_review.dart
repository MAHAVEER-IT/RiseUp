import 'package:isar/isar.dart';

part 'weekly_review.g.dart';

@collection
class WeeklyReview {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime weekStartDate;

  late String aiInsights;
  late double avgEnergy;
  late int totalFocusMinutes;

  late DateTime createdAt;
}
