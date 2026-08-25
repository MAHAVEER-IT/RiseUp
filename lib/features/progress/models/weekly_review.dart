import 'package:isar/isar.dart';

part 'weekly_review.g.dart';

@collection
class WeeklyReview {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime weekStartDate;

  late String aiInsights;

  late double avgEnergy;

  late int totalFocusMinutes;

  @Index()
  late DateTime createdAt;

  WeeklyReview({
    required this.weekStartDate,
    required this.aiInsights,
    required this.avgEnergy,
    required this.totalFocusMinutes,
  }) {
    createdAt = DateTime.now();
  }

  WeeklyReview.empty();
}
