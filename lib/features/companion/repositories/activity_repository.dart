import 'package:isar/isar.dart';
import '../models/activity_log.dart';

class ActivityRepository {
  final Isar isar;

  ActivityRepository(this.isar);

  Future<void> saveActivity(ActivityLog activity) async {
    await isar.writeTxn(() async {
      await isar.activityLogs.put(activity);
    });
  }

  Future<ActivityLog?> getLatestActivity() async {
    return await isar.activityLogs.where().sortByTimestampDesc().findFirst();
  }

  Future<List<ActivityLog>> getActivitiesForToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return await isar.activityLogs
        .where()
        .timestampBetween(startOfDay, endOfDay)
        .sortByTimestampDesc()
        .findAll();
  }

  Future<List<ActivityLog>> getActivitiesForLastDays(int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    return await isar.activityLogs
        .where()
        .timestampGreaterThan(startDate)
        .sortByTimestampDesc()
        .findAll();
  }

  Future<void> updateActivityWithAIResponse(
    int activityId, {
    required String encouragement,
    required String suggestion,
    required String focusGuidance,
  }) async {
    await isar.writeTxn(() async {
      final activity = await isar.activityLogs.get(activityId);
      if (activity != null) {
        activity.aiEncouragement = encouragement;
        activity.aiSuggestion = suggestion;
        activity.aiFocusGuidance = focusGuidance;
        activity.aiResponseGenerated = true;
        await isar.activityLogs.put(activity);
      }
    });
  }

  Future<void> deleteActivity(int id) async {
    await isar.writeTxn(() async {
      await isar.activityLogs.delete(id);
    });
  }

  Future<int> getTodayActivityCount() async {
    final activities = await getActivitiesForToday();
    return activities.length;
  }
}
