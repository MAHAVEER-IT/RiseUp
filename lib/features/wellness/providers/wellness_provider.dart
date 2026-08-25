import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/features/wellness/models/daily_check_in.dart';
import 'package:riseup/features/wellness/models/mood_log.dart';
import 'package:riseup/features/wellness/repositories/wellness_repository.dart';

final wellnessRepositoryProvider = Provider<WellnessRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return WellnessRepository(isar);
});

final todayCheckInProvider =
    AsyncNotifierProvider<TodayCheckInNotifier, DailyCheckIn>(() {
      return TodayCheckInNotifier();
    });

class TodayCheckInNotifier extends AsyncNotifier<DailyCheckIn> {
  @override
  Future<DailyCheckIn> build() async {
    final repository = ref.watch(wellnessRepositoryProvider);
    return await repository.getOrCreateTodayCheckIn();
  }

  Future<void> submitMorningCheckIn(int mood, int energy, {String? note}) async {
    final repository = ref.read(wellnessRepositoryProvider);
    final isar = ref.read(isarProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final checkIn = await repository.getOrCreateTodayCheckIn();
      checkIn.morningCompleted = true;
      checkIn.moodScore = mood.toUnsigned(8);
      checkIn.energyScore = energy.toUnsigned(8);
      await repository.saveCheckIn(checkIn);

      final trimmedNote = note?.trim();
      final moodLog = MoodLog()
        ..timestamp = DateTime.now()
        ..moodScore = mood.toUnsigned(8)
        ..energyScore = energy.toUnsigned(8)
        ..note = trimmedNote == null || trimmedNote.isEmpty
            ? null
            : trimmedNote;

      await isar.writeTxn(() async {
        await isar.moodLogs.put(moodLog);
      });

      return checkIn;
    });
  }
}
