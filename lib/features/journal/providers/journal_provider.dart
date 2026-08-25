import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/features/journal/models/reflection.dart';
import 'package:riseup/features/journal/models/english_practice_speaking_log.dart';
import 'package:riseup/features/journal/repositories/journal_repository.dart';
import 'package:riseup/features/journal/repositories/english_practice_repository.dart';

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return JournalRepository(isar);
});

final journalProvider =
    AsyncNotifierProvider<JournalNotifier, List<Reflection>>(() {
      return JournalNotifier();
    });

class JournalNotifier extends AsyncNotifier<List<Reflection>> {
  @override
  Future<List<Reflection>> build() async {
    return ref.watch(journalRepositoryProvider).getReflectionsForLastDays(30);
  }

  Future<void> saveReflection(String content, String smallWin) async {
    final repository = ref.read(journalRepositoryProvider);
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final reflection = Reflection()
      ..date = startOfDay
      ..content = content
      ..smallWin = smallWin
      ..createdAt = DateTime.now();

    await repository.saveReflection(reflection);
    state = await AsyncValue.guard(() => build());
  }
}

final englishPracticeRepositoryProvider = Provider<EnglishPracticeRepository>((
  ref,
) {
  final isar = ref.watch(isarProvider);
  return EnglishPracticeRepository(isar);
});

final englishPracticeLogsProvider =
    AsyncNotifierProvider<
      EnglishPracticeLogsNotifier,
      List<EnglishPracticeSpeakingLog>
    >(() {
      return EnglishPracticeLogsNotifier();
    });

class EnglishPracticeLogsNotifier
    extends AsyncNotifier<List<EnglishPracticeSpeakingLog>> {
  @override
  Future<List<EnglishPracticeSpeakingLog>> build() async {
    return ref
        .watch(englishPracticeRepositoryProvider)
        .getPracticeLogsForLastDays(30);
  }

  Future<void> savePracticeLog(
    int durationMinutes,
    PracticeMedium medium, {
    String? topic,
    String? notes,
    int? fluencyRating,
    int? confidenceRating,
    int? comprensionRating,
  }) async {
    final repository = ref.read(englishPracticeRepositoryProvider);
    final streak = await repository.getPracticeStreak();

    final log = EnglishPracticeSpeakingLog(
      timestamp: DateTime.now(),
      durationMinutes: durationMinutes,
      medium: medium,
      topic: topic,
      notes: notes,
      fluencyRating: fluencyRating,
      confidenceRating: confidenceRating,
      comprensionRating: comprensionRating,
      streakDays: streak + 1,
    );

    await repository.savePracticeLog(log);
    state = await AsyncValue.guard(() => build());
  }

  Future<void> deletePracticeLog(int id) async {
    final repository = ref.read(englishPracticeRepositoryProvider);
    await repository.deletePracticeLog(id);
    state = await AsyncValue.guard(() => build());
  }
}
