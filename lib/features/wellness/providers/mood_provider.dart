import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/features/wellness/models/mood_log.dart';
import 'package:riseup/features/wellness/repositories/wellness_extended_repository.dart';

final wellnessExtendedRepositoryProvider = Provider<WellnessExtendedRepository>(
  (ref) {
    final isar = ref.watch(isarProvider);
    return WellnessExtendedRepository(isar);
  },
);

final latestMoodProvider = AsyncNotifierProvider<LatestMoodNotifier, MoodLog?>(
  () {
    return LatestMoodNotifier();
  },
);

class LatestMoodNotifier extends AsyncNotifier<MoodLog?> {
  @override
  Future<MoodLog?> build() async {
    return ref.watch(wellnessExtendedRepositoryProvider).getLatestMoodLog();
  }

  Future<void> logMood(int moodScore, int energyScore, String? note) async {
    final repository = ref.read(wellnessExtendedRepositoryProvider);
    final moodLog = MoodLog()
      ..timestamp = DateTime.now()
      ..moodScore = moodScore.toUnsigned(8)
      ..energyScore = energyScore.toUnsigned(8)
      ..note = note;

    await repository.saveMoodLog(moodLog);
    state = AsyncValue.data(moodLog);
  }
}
