import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/network/gemini_provider.dart';
import 'package:riseup/core/network/weekly_review_generation_service.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/features/progress/repositories/progress_repository.dart';
import 'package:riseup/features/wellness/repositories/wellness_extended_repository.dart';
import 'package:riseup/features/goals/repositories/todo_repository.dart';
import 'package:riseup/features/journal/repositories/journal_repository.dart';
import 'package:riseup/features/progress/models/weekly_review.dart';

import 'package:riseup/core/network/gemini_provider.dart';

final weeklyReviewGenerationServiceProvider =
    Provider<WeeklyReviewGenerationService>((ref) {
      final isar = ref.watch(isarProvider);
      final geminiService = ref.watch(geminiServiceProvider);

      final progressRepository = ProgressRepository(isar);
      final wellnessRepository = WellnessExtendedRepository(isar);
      final todoRepository = TodoRepository(isar);
      final journalRepository = JournalRepository(isar);

      return WeeklyReviewGenerationService(
        geminiService: geminiService,
        progressRepository: progressRepository,
        wellnessRepository: wellnessRepository,
        todoRepository: todoRepository,
        journalRepository: journalRepository,
      );
    });

// Notifier to check and generate weekly review if needed
final weeklyReviewCheckerProvider =
    AsyncNotifierProvider<WeeklyReviewCheckerNotifier, void>(() {
      return WeeklyReviewCheckerNotifier();
    });

class WeeklyReviewCheckerNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    final service = ref.read(weeklyReviewGenerationServiceProvider);

    // Check if we should generate a review (only on Sundays and if not already done)
    final now = DateTime.now();
    if (now.weekday == 7) {
      // 7 = Sunday
      final shouldGenerate = await service.shouldGenerateReview();
      if (shouldGenerate) {
        try {
          await service.generateAndSaveWeeklyReview();
        } catch (e) {
          print('Failed to auto-generate weekly review: $e');
        }
      }
    }
  }

  Future<void> forceGenerateReview() async {
    final service = ref.read(weeklyReviewGenerationServiceProvider);
    await AsyncValue.guard(() => service.generateAndSaveWeeklyReview());
  }
}

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return ProgressRepository(isar);
});

final weeklyReviewsProvider =
    AsyncNotifierProvider<WeeklyReviewsNotifier, List<WeeklyReview>>(() {
      return WeeklyReviewsNotifier();
    });

class WeeklyReviewsNotifier extends AsyncNotifier<List<WeeklyReview>> {
  @override
  Future<List<WeeklyReview>> build() async {
    return ref.read(progressRepositoryProvider).getAllWeeklyReviews();
  }

  Future<void> deleteWeeklyReview(int id) async {
    final repository = ref.read(progressRepositoryProvider);
    await repository.deleteWeeklyReview(id);
    state = await AsyncValue.guard(() => build());
  }
}
