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
    final startOfDay = DateTime(now.year, now.month, now.day);
    final weekStartDate = startOfDay.subtract(Duration(days: now.weekday - 1));
    
    final existing = await _progressRepository.getWeeklyReviewForDate(weekStartDate);
    return existing == null;
  }

  Future<void> generateAndSaveWeeklyReview() async {
    try {
      final completedTasksCount = await _todoRepository.getCompletedTodosCountLastDays(7);

      // Build prompt for Gemini
      final dataContext = _buildWeeklyReviewContext(
        completedTasks: completedTasksCount,
      );

      // Send to Gemini for synthesis
      final aiInsights = await _geminiService.generateWeeklyInsights(dataContext);

      // Save or update the review for current week
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final weekStart = startOfDay.subtract(Duration(days: now.weekday - 1));
      
      final existing = await _progressRepository.getWeeklyReviewForDate(weekStart);
      final review = WeeklyReview(
        weekStartDate: weekStart,
        aiInsights: aiInsights,
        avgEnergy: 0.0,
        totalFocusMinutes: completedTasksCount, // Re-use totalFocusMinutes to hold completed tasks count
      );
      if (existing != null) {
        review.id = existing.id;
      }

      await _progressRepository.saveWeeklyReview(review);
    } catch (e) {
      print('Error generating weekly review: $e');
      rethrow;
    }
  }

  String _buildWeeklyReviewContext({
    required int completedTasks,
  }) {
    final buffer = StringBuffer();
    
    buffer.writeln('Weekly Review Data:');
    buffer.writeln('- Total tasks completed: $completedTasks');
    
    buffer.writeln('\nProvide a compassionate, motivating summary of the week.');
    buffer.writeln('Highlight: progress made, consistency with completing tasks, and daily victories.');
    buffer.writeln('Suggest: one actionable improvement for next week.');
    buffer.writeln('Tone: Like a supportive accountability partner, never shaming.');
    buffer.writeln(
      'Formatting: wrap only important notes or key actions in **double asterisks** so the app can show them in bold. Use this sparingly, around 1 to 3 short phrases.',
    );

    return buffer.toString();
  }
}
