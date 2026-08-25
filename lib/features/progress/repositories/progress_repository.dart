import 'package:isar/isar.dart';
import 'package:riseup/features/progress/models/weekly_review.dart';

class ProgressRepository {
  final Isar _isar;

  ProgressRepository(this._isar);

  Future<void> saveWeeklyReview(WeeklyReview review) async {
    await _isar.writeTxn(() async {
      await _isar.weeklyReviews.put(review);
    });
  }

  Future<WeeklyReview?> getWeeklyReviewForDate(DateTime weekStartDate) async {
    final startOfDay = DateTime(weekStartDate.year, weekStartDate.month, weekStartDate.day);
    final endOfDay = DateTime(weekStartDate.year, weekStartDate.month, weekStartDate.day, 23, 59, 59);

    return await _isar.weeklyReviews
        .where()
        .weekStartDateBetween(startOfDay, endOfDay)
        .findFirst();
  }

  Future<List<WeeklyReview>> getAllWeeklyReviews() async {
    return await _isar.weeklyReviews
        .where()
        .sortByWeekStartDateDesc()
        .findAll();
  }

  Future<void> deleteWeeklyReview(int id) async {
    await _isar.writeTxn(() async {
      await _isar.weeklyReviews.delete(id);
    });
  }
}
