import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'package:riseup/features/goals/models/todo.dart';
import 'package:riseup/features/journal/models/english_practice_speaking_log.dart';
import 'package:riseup/features/journal/models/reflection.dart';
import 'package:riseup/features/progress/models/achievement.dart';
import 'package:riseup/features/progress/models/weekly_review.dart';
import 'package:riseup/features/wellness/models/daily_check_in.dart';
import 'package:riseup/features/wellness/models/mood_log.dart';

final progressSummaryProvider =
    FutureProvider<ProgressSummary>((ref) async {
      final isar = ref.watch(isarProvider);
      return ProgressSummary.load(isar: isar, days: 7);
    });

class ProgressSummary {
  final DateTime startDate;
  final DateTime endDate;
  final MoodLog? latestMood;
  final List<DailyCheckIn> checkIns;
  final List<MoodLog> moodLogs;
  final List<Todo> todos;
  final List<Todo> activeTodos;
  final List<Reflection> reflections;
  final List<EnglishPracticeSpeakingLog> englishLogs;
  final List<ActivityLog> activities;
  final List<Achievement> achievements;
  final List<WeeklyReview> weeklyReviews;
  final int allTimeActiveDays;
  final int allTimeCompletedTodos;

  const ProgressSummary({
    required this.startDate,
    required this.endDate,
    required this.latestMood,
    required this.checkIns,
    required this.moodLogs,
    required this.todos,
    required this.activeTodos,
    required this.reflections,
    required this.englishLogs,
    required this.activities,
    required this.achievements,
    required this.weeklyReviews,
    required this.allTimeActiveDays,
    required this.allTimeCompletedTodos,
  });

  static Future<ProgressSummary> load({
    required Isar isar,
    required int days,
  }) async {
    final now = DateTime.now();
    final start = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: days - 1));
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final latestMood = await isar.moodLogs
        .where()
        .sortByTimestampDesc()
        .findFirst();
    final checkIns = await isar.dailyCheckIns
        .filter()
        .dateBetween(start, end)
        .sortByDateDesc()
        .findAll();
    final moodLogs = await isar.moodLogs
        .filter()
        .timestampBetween(start, end)
        .sortByTimestampDesc()
        .findAll();
    final todos = await isar.todos
        .filter()
        .createdAtBetween(start, end)
        .sortByCreatedAtDesc()
        .findAll();
    final activeTodos = await isar.todos
        .filter()
        .isCompletedEqualTo(false)
        .findAll();
    final reflections = await isar.reflections
        .filter()
        .dateBetween(start, end)
        .sortByDateDesc()
        .findAll();
    final englishLogs = await isar.englishPracticeSpeakingLogs
        .filter()
        .timestampBetween(start, end)
        .sortByTimestampDesc()
        .findAll();
    final activities = await isar.activityLogs
        .filter()
        .timestampBetween(start, end)
        .sortByTimestampDesc()
        .findAll();
    final achievements = await isar.achievements
        .filter()
        .unlockedAtBetween(start, end)
        .sortByUnlockedAtDesc()
        .findAll();
    final weeklyReviews = await isar.weeklyReviews
        .where()
        .sortByWeekStartDateDesc()
        .findAll();

    final allCompletedTodos = await isar.todos
        .filter()
        .isCompletedEqualTo(true)
        .findAll();

    final allTimeActiveDates = allCompletedTodos
        .map((t) => DateTime(
              t.createdAt.year,
              t.createdAt.month,
              t.createdAt.day,
            ))
        .toSet();

    final allCheckIns = await isar.dailyCheckIns
        .filter()
        .morningCompletedEqualTo(true)
        .or()
        .eveningCompletedEqualTo(true)
        .findAll();

    for (final c in allCheckIns) {
      allTimeActiveDates.add(DateTime(c.date.year, c.date.month, c.date.day));
    }

    final allReflections = await isar.reflections.where().findAll();
    for (final r in allReflections) {
      allTimeActiveDates.add(DateTime(r.date.year, r.date.month, r.date.day));
    }

    final allEnglishLogs =
        await isar.englishPracticeSpeakingLogs.where().findAll();
    for (final log in allEnglishLogs) {
      allTimeActiveDates.add(
        DateTime(log.timestamp.year, log.timestamp.month, log.timestamp.day),
      );
    }

    final allTimeActiveDays = allTimeActiveDates.length;
    final allTimeCompletedTodos = allCompletedTodos.length;

    return ProgressSummary(
      startDate: start,
      endDate: end,
      latestMood: latestMood,
      checkIns: checkIns,
      moodLogs: moodLogs,
      todos: todos,
      activeTodos: activeTodos,
      reflections: reflections,
      englishLogs: englishLogs,
      activities: activities,
      achievements: achievements,
      weeklyReviews: weeklyReviews,
      allTimeActiveDays: allTimeActiveDays,
      allTimeCompletedTodos: allTimeCompletedTodos,
    );
  }

  int get totalCompletedTodos => todos.where((t) => t.isCompleted).length;

  int get totalEnglishMinutes => englishLogs.fold(
    0,
    (sum, log) => sum + log.durationMinutes,
  );

  int get activeFocusDays => todos
      .where((t) => t.isCompleted)
      .map((t) => DateTime(
            t.createdAt.year,
            t.createdAt.month,
            t.createdAt.day,
          ))
      .toSet()
      .length;

  int get checkInDays => checkIns
      .where((checkIn) => checkIn.morningCompleted || checkIn.eveningCompleted)
      .length;

  int get reflectionDays => reflections.length;

  int get quickUpdates => activities.length;

  int get aiResponses => activities
      .where((activity) => activity.aiResponseGenerated)
      .length;

  int get distractionUpdates => activities
      .where(
        (activity) =>
            activity.activity == ActivityType.instagram ||
            activity.activity == ActivityType.youtube,
      )
      .length;

  int get recoveryUpdates => activities
      .where(
        (activity) =>
            activity.activity == ActivityType.feelingLow ||
            activity.activity == ActivityType.feelingTired ||
            activity.activity == ActivityType.takingBreak,
      )
      .length;

  double? get averageMood {
    if (moodLogs.isEmpty) return null;
    final total = moodLogs.fold<int>(0, (sum, log) => sum + log.moodScore);
    return total / moodLogs.length;
  }

  double? get averageEnergy {
    if (moodLogs.isEmpty) return null;
    final total = moodLogs.fold<int>(0, (sum, log) => sum + log.energyScore);
    return total / moodLogs.length;
  }

  List<String> get smallWins => reflections
      .map((reflection) => reflection.smallWin)
      .where((win) => win.trim().isNotEmpty)
      .take(5)
      .toList();

  int get proofScore {
    var score = 0;
    score += totalCompletedTodos * 12;
    score += activeFocusDays * 12;
    score += achievements.length * 10;
    return score.clamp(0, 100);
  }

  String get headline {
    if (proofScore >= 75) return 'Your week has real momentum';
    if (proofScore >= 45) return 'Your effort is becoming visible';
    if (proofScore > 0) return 'Small proof is already here';
    return 'Your proof starts with one small action';
  }

  String get companionMessage {
    if (proofScore >= 75) {
      return 'You are stacking completed tasks and consistency. This is momentum in motion.';
    }
    if (proofScore >= 45) {
      return 'The page is picking up your effort. Keep completing your daily to-dos.';
    }
    if (proofScore > 0) {
      return 'You have started leaving proof. One more completed to-do will build your momentum.';
    }
    return 'Complete your daily to-dos and this page will begin telling your story.';
  }
}
