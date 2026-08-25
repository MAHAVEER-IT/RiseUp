import 'package:riseup/core/network/gemini_service.dart';
import 'package:riseup/features/progress/repositories/progress_repository.dart';
import 'package:riseup/features/wellness/repositories/wellness_extended_repository.dart';
import 'package:riseup/features/goals/repositories/todo_repository.dart';
import 'package:riseup/features/journal/repositories/journal_repository.dart';
import 'package:riseup/features/progress/models/weekly_review.dart';

class WeeklyReviewGenerationService {
  final GeminiService _geminiService;
  final ProgressRepository _progressRepository;
  final WellnessExtendedRepository _wellnessRepository;
  final TodoRepository _todoRepository;
  final JournalRepository _journalRepository;

  WeeklyReviewGenerationService({
    required GeminiService geminiService,
    required ProgressRepository progressRepository,
    required WellnessExtendedRepository wellnessRepository,
    required TodoRepository todoRepository,
    required JournalRepository journalRepository,
  })  : _geminiService = geminiService,
        _progressRepository = progressRepository,
        _wellnessRepository = wellnessRepository,
        _todoRepository = todoRepository,
        _journalRepository = journalRepository;

  Future<bool> shouldGenerateReview() async {
    // Check if we already generated a review this week
    final now = DateTime.now();
    final weekStartDate = DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 7)); // Start of current week
    
    final existing = await _progressRepository.getWeeklyReviewForDate(weekStartDate);
    return existing == null;
  }

  Future<void> generateAndSaveWeeklyReview() async {
    try {
      // Collect data from the past 7 days
      final reflections = await _journalRepository.getReflectionsForLastDays(7);
      final moodLogs = await _wellnessRepository.getMoodLogsForLastDays(7);
      final completedTasksCount = await _todoRepository.getCompletedTodosCountLastDays(7);

      // Calculate average energy
      int totalEnergy = 0;
      for (final log in moodLogs) {
        totalEnergy += log.energyScore;
      }
      final avgEnergy = moodLogs.isNotEmpty ? (totalEnergy / moodLogs.length).toStringAsFixed(1) : "N/A";

      // Build prompt for Gemini
      final dataContext = _buildWeeklyReviewContext(
        reflections: reflections,
        moodCount: moodLogs.length,
        avgEnergy: avgEnergy,
        completedTasks: completedTasksCount,
      );

      // Send to Gemini for synthesis
      final aiInsights = await _geminiService.generateWeeklyInsights(dataContext);

      // Save the review
      final weekStart = DateTime.now()
          .subtract(Duration(days: DateTime.now().weekday - 1));
      
      final avgEnergyDouble = double.tryParse(avgEnergy) ?? 0.0;
      
      final review = WeeklyReview(
        weekStartDate: weekStart,
        aiInsights: aiInsights,
        avgEnergy: avgEnergyDouble,
        totalFocusMinutes: completedTasksCount, // Re-use totalFocusMinutes to hold completed tasks count
      );

      await _progressRepository.saveWeeklyReview(review);
    } catch (e) {
      print('Error generating weekly review: $e');
      rethrow;
    }
  }

  String _buildWeeklyReviewContext({
    required List reflections,
    required int moodCount,
    required String avgEnergy,
    required int completedTasks,
  }) {
    final buffer = StringBuffer();
    
    buffer.writeln('Weekly Review Data:');
    buffer.writeln('- Reflections logged: ${reflections.length}');
    buffer.writeln('- Average energy level: $avgEnergy/5');
    buffer.writeln('- Total tasks completed: $completedTasks');
    buffer.writeln('- Mood check-ins: $moodCount');
    
    if (reflections.isNotEmpty) {
      buffer.writeln('\nKey Reflections:');
      for (final reflection in reflections.take(3)) {
        buffer.writeln('- Small win: ${reflection.smallWin}');
      }
    }
    
    buffer.writeln('\nProvide a compassionate, motivating summary of the week.');
    buffer.writeln('Highlight: progress made, energy patterns, consistency with completing tasks.');
    buffer.writeln('Suggest: one actionable improvement for next week.');
    buffer.writeln('Tone: Like a supportive accountability partner, never shaming.');
    buffer.writeln(
      'Formatting: wrap only important notes or key actions in **double asterisks** so the app can show them in bold. Use this sparingly, around 1 to 3 short phrases.',
    );

    return buffer.toString();
  }
}
