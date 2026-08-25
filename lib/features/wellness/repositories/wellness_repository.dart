import 'package:isar/isar.dart';
import '../models/daily_check_in.dart';

class WellnessRepository {
  final Isar isar;

  WellnessRepository(this.isar);

  Future<DailyCheckIn?> getCheckInForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    return await isar.dailyCheckIns.where().dateEqualTo(startOfDay).findFirst();
  }

  Future<void> saveCheckIn(DailyCheckIn checkIn) async {
    await isar.writeTxn(() async {
      await isar.dailyCheckIns.put(checkIn);
    });
  }

  Future<DailyCheckIn> getOrCreateTodayCheckIn() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    var checkIn = await getCheckInForDate(startOfDay);

    if (checkIn == null) {
      checkIn = DailyCheckIn()
        ..date = startOfDay
        ..morningCompleted = false
        ..eveningCompleted = false
        ..moodScore = 3
        ..energyScore = 3;
      await saveCheckIn(checkIn);
    }

    return checkIn;
  }
}
