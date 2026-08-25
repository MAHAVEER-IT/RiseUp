import 'package:isar/isar.dart';
import '../models/mood_log.dart';

class WellnessExtendedRepository {
  final Isar isar;

  WellnessExtendedRepository(this.isar);

  Future<void> saveMoodLog(MoodLog log) async {
    await isar.writeTxn(() async {
      await isar.moodLogs.put(log);
    });
  }

  Future<MoodLog?> getLatestMoodLog() async {
    return await isar.moodLogs.where().sortByTimestampDesc().findFirst();
  }

  Future<List<MoodLog>> getMoodLogsForLastDays(int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    return await isar.moodLogs
        .filter()
        .timestampGreaterThan(startDate)
        .sortByTimestampDesc()
        .findAll();
  }
}
