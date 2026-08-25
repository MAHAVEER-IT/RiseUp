import 'package:isar/isar.dart';
import 'package:riseup/features/progress/models/weekly_review.dart';

class ProgressRepository {
  final Isar isar;

  ProgressRepository(this.isar);

  Future<void> saveWeeklyReview(WeeklyReview review) async {
    await isar.writeTxn(() async {
      await isar.weeklyReviews.put(review);
    });
  }

  Future<WeeklyReview?> getWeeklyReviewForDate(DateTime date) async {
    return await isar.weeklyReviews
        .where()
        .weekStartDateEqualTo(date)
        .findFirst();
  }

  Future<List<WeeklyReview>> getAllWeeklyReviews() async {
    return await isar.weeklyReviews.where().sortByWeekStartDateDesc().findAll();
  }
}
