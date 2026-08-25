import 'package:isar/isar.dart';
import 'package:riseup/features/journal/models/english_practice_speaking_log.dart';

class EnglishPracticeRepository {
  final Isar _isar;

  EnglishPracticeRepository(this._isar);

  Future<void> savePracticeLog(EnglishPracticeSpeakingLog log) async {
    await _isar.writeTxn(() async {
      await _isar.englishPracticeSpeakingLogs.put(log);
    });
  }

  Future<List<EnglishPracticeSpeakingLog>> getPracticeLogsForLastDays(
    int days,
  ) async {
    final since = DateTime.now().subtract(Duration(days: days));
    return await _isar.englishPracticeSpeakingLogs
        .where()
        .timestampGreaterThan(since)
        .sortByTimestampDesc()
        .findAll();
  }

  Future<EnglishPracticeSpeakingLog?> getLatestPracticeLog() async {
    return await _isar.englishPracticeSpeakingLogs
        .where()
        .sortByTimestampDesc()
        .findFirst();
  }

  Future<List<EnglishPracticeSpeakingLog>> getPracticeLogsForToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return await _isar.englishPracticeSpeakingLogs
        .where()
        .timestampBetween(startOfDay, endOfDay)
        .sortByTimestampDesc()
        .findAll();
  }

  Future<int> getTotalPracticeDurationLastDays(int days) async {
    final logs = await getPracticeLogsForLastDays(days);
    int totalMinutes = 0;
    for (final log in logs) {
      totalMinutes += log.durationMinutes;
    }
    return totalMinutes;
  }

  Future<int> getPracticeStreak() async {
    final now = DateTime.now();
    int streak = 0;

    for (int i = 0; i < 365; i++) {
      final date = now.subtract(Duration(days: i));
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final logs = await _isar.englishPracticeSpeakingLogs
          .where()
          .timestampBetween(startOfDay, endOfDay)
          .findAll();

      if (logs.isEmpty) {
        break;
      }
      streak++;
    }

    return streak;
  }

  Future<void> deletePracticeLog(int id) async {
    await _isar.writeTxn(() async {
      await _isar.englishPracticeSpeakingLogs.delete(id);
    });
  }
}
