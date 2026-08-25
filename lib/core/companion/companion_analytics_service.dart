import 'package:riseup/features/companion/models/companion_analytics.dart';
import 'package:riseup/features/companion/repositories/activity_repository.dart';
import 'package:riseup/features/companion/models/activity_log.dart';

class CompanionAnalyticsService {
  final ActivityRepository _activityRepository;

  CompanionAnalyticsService(this._activityRepository);

  /// Generate daily analytics for tracking patterns
  Future<CompanionAnalytics> generateDailyAnalytics(DateTime date) async {
    final dayActivities = await _activityRepository.getActivitiesForToday();
    final weekActivities = await _activityRepository.getActivitiesForLastDays(
      7,
    );

    final analytics = CompanionAnalytics()
      ..date = DateTime(date.year, date.month, date.day)
      ..totalCheckIns = dayActivities.length
      ..ignoredCheckIns =
          0 // Would need to track this separately
      ..activityFrequency = _analyzeActivityFrequency(dayActivities)
      ..moodFrequency = _analyzeMoodFrequency(dayActivities)
      ..energyLevels = _analyzeEnergyLevels(dayActivities)
      ..activityByTimeOfDay = _analyzeActivityByTimeOfDay(dayActivities)
      ..focusHourSuccessRate = _calculateFocusHourSuccessRate(weekActivities)
      ..topDistractions = _identifyTopDistractions(weekActivities)
      ..englishPracticeSessions = _countActivity(
        dayActivities,
        'English Practice',
      )
      ..englishPracticeMinutes = _estimatePracticeMinutes(
        dayActivities,
        'English Practice',
      )
      ..engagementScore = _calculateEngagementScore(
        dayActivities,
        weekActivities,
      )
      ..lastEngagedAt = dayActivities.isNotEmpty
          ? dayActivities.last.timestamp
          : DateTime.now()
      ..favoriteActivities = _identifyFavoriteActivities(weekActivities)
      ..commonNotes = _extractCommonNotes(weekActivities)
      ..personalizedTips = {}; // Would be populated from Gemini

    return analytics;
  }

  /// Generate weekly insights report
  Future<String> generateWeeklyInsights() async {
    final weekActivities = await _activityRepository.getActivitiesForLastDays(
      7,
    );

    final totalCheckIns = weekActivities.length;
    final avgPerDay = totalCheckIns / 7;
    final mostCommonActivity = _getMostCommonActivity(weekActivities);
    final avgMood = _calculateAverageMood(weekActivities);
    final avgEnergy = _calculateAverageEnergy(weekActivities);
    final bestFocusHour = _identifyBestFocusHour(weekActivities);
    final topDistractions = _identifyTopDistractions(weekActivities);
    final englishPracticeDays = _countDaysWithActivity(
      weekActivities,
      'English Practice',
    );

    return '''
📊 YOUR WEEK AT A GLANCE

Check-in Summary:
• Total check-ins: $totalCheckIns
• Average per day: ${avgPerDay.toStringAsFixed(1)}
• Engagement: ${_getEngagementRating(avgPerDay)}

Activity Insights:
• Most common: $mostCommonActivity
• Average mood: ${_moodToEmoji(avgMood)} (${avgMood.toStringAsFixed(1)}/5)
• Average energy: ${_energyToEmoji(avgEnergy)} (${avgEnergy.toStringAsFixed(1)}/5)

Focus Patterns:
• Best focus hour: ${bestFocusHour}:00
• Top distractions: ${topDistractions.take(3).join(', ')}

Growth:
• English practice days: $englishPracticeDays/7
• Keep building momentum! 💪

📈 What's Working:
${_generatePositiveFeedback(weekActivities)}

💡 Next Week Challenge:
${_generateChallenge(weekActivities)}
''';
  }

  // Analysis helpers
  Map<String, int> _analyzeActivityFrequency(List<ActivityLog> activities) {
    final freq = <String, int>{};
    for (final activity in activities) {
      final name = _getActivityName(activity.activity);
      freq[name] = (freq[name] ?? 0) + 1;
    }
    return freq;
  }

  Map<String, int> _analyzeMoodFrequency(List<ActivityLog> activities) {
    final freq = <String, int>{};
    for (final activity in activities) {
      if (activity.moodRating != null) {
        final mood = _moodToString(activity.moodRating!);
        freq[mood] = (freq[mood] ?? 0) + 1;
      }
    }
    return freq;
  }

  Map<int, int> _analyzeEnergyLevels(List<ActivityLog> activities) {
    final energy = <int, int>{};
    for (final activity in activities) {
      if (activity.energyLevel != null) {
        energy[activity.energyLevel!] =
            (energy[activity.energyLevel!] ?? 0) + 1;
      }
    }
    return energy;
  }

  Map<String, int> _analyzeActivityByTimeOfDay(List<ActivityLog> activities) {
    final timeOfDay = <String, int>{};
    for (final activity in activities) {
      final period = _getTimePeriod(activity.timestamp.hour);
      final name = _getActivityName(activity.activity);
      final key = '$period - $name';
      timeOfDay[key] = (timeOfDay[key] ?? 0) + 1;
    }
    return timeOfDay;
  }

  Map<int, int> _calculateFocusHourSuccessRate(List<ActivityLog> activities) {
    final hourStats = <int, Map<String, int>>{};

    for (final activity in activities) {
      final hour = activity.timestamp.hour;
      final current = hourStats[hour] ?? {'total': 0, 'focused': 0};
      final isFocused = _isFocusedActivity(activity.activity);
      current['total'] = current['total']! + 1;
      if (isFocused) {
        current['focused'] = current['focused']! + 1;
      }
      hourStats[hour] = current;
    }

    // Convert to success rate percentage
    final result = <int, int>{};
    hourStats.forEach((hour, stats) {
      final total = stats['total'] ?? 1;
      final focused = stats['focused'] ?? 0;
      result[hour] = ((focused / total) * 100).toInt();
    });
    return result;
  }

  List<String> _identifyTopDistractions(List<ActivityLog> activities) {
    final distractions = <String, int>{};
    for (final activity in activities) {
      if (_isDistractionActivity(activity.activity)) {
        final name = _getActivityName(activity.activity);
        distractions[name] = (distractions[name] ?? 0) + 1;
      }
    }

    final sortedDistractions = distractions.entries.toList();
    sortedDistractions.sort((a, b) => b.value.compareTo(a.value));
    return sortedDistractions.take(5).map((e) => e.key).toList();
  }

  List<String> _identifyFavoriteActivities(List<ActivityLog> activities) {
    final freq = _analyzeActivityFrequency(activities);
    final sortedFreq = freq.entries.toList();
    sortedFreq.sort((a, b) => b.value.compareTo(a.value));
    return sortedFreq.take(3).map((e) => e.key).toList();
  }

  List<String> _extractCommonNotes(List<ActivityLog> activities) {
    final notes = <String, int>{};
    for (final activity in activities) {
      if (activity.additionalNote != null &&
          activity.additionalNote!.isNotEmpty) {
        notes[activity.additionalNote!] =
            (notes[activity.additionalNote!] ?? 0) + 1;
      }
    }

    final sortedNotes = notes.entries.toList();
    sortedNotes.sort((a, b) => b.value.compareTo(a.value));
    return sortedNotes
        .where((e) => e.value >= 2) // Only repeated notes
        .take(10)
        .map((e) => e.key)
        .toList();
  }

  int _countActivity(List<ActivityLog> activities, String activityName) {
    return activities
        .where((a) => _getActivityName(a.activity) == activityName)
        .length;
  }

  int _estimatePracticeMinutes(
    List<ActivityLog> activities,
    String activityName,
  ) {
    // Estimate 30 min per session on average
    return _countActivity(activities, activityName) * 30;
  }

  double _calculateEngagementScore(
    List<ActivityLog> dayActivities,
    List<ActivityLog> weekActivities,
  ) {
    final avgCheckIns = weekActivities.length / 7;
    final todayCheckIns = dayActivities.length;
    final consistencyScore = (avgCheckIns / 10) * 100;
    final todayScore = (todayCheckIns / 15) * 100;

    return ((consistencyScore + todayScore) / 2).clamp(0, 100);
  }

  String _getMostCommonActivity(List<ActivityLog> activities) {
    final freq = _analyzeActivityFrequency(activities);
    if (freq.isEmpty) return 'N/A';
    return freq.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  double _calculateAverageMood(List<ActivityLog> activities) {
    final validMoods = activities
        .where((a) => a.moodRating != null)
        .map((a) => a.moodRating!)
        .toList();
    if (validMoods.isEmpty) return 3.0;
    return validMoods.reduce((a, b) => a + b) / validMoods.length;
  }

  double _calculateAverageEnergy(List<ActivityLog> activities) {
    final validEnergy = activities
        .where((a) => a.energyLevel != null)
        .map((a) => a.energyLevel!)
        .toList();
    if (validEnergy.isEmpty) return 3.0;
    return validEnergy.reduce((a, b) => a + b) / validEnergy.length;
  }

  int _identifyBestFocusHour(List<ActivityLog> activities) {
    final hourStats = _calculateFocusHourSuccessRate(activities);
    if (hourStats.isEmpty) return 9;
    return hourStats.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  int _countDaysWithActivity(
    List<ActivityLog> activities,
    String activityName,
  ) {
    final days = <DateTime>{};
    for (final activity in activities) {
      if (_getActivityName(activity.activity) == activityName) {
        days.add(
          DateTime(
            activity.timestamp.year,
            activity.timestamp.month,
            activity.timestamp.day,
          ),
        );
      }
    }
    return days.length;
  }

  // Utility helpers
  String _getActivityName(ActivityType type) {
    switch (type) {
      case ActivityType.inLecture:
        return 'In Lecture';
      case ActivityType.studying:
        return 'Studying';
      case ActivityType.dsa:
        return 'DSA';
      case ActivityType.dbms:
        return 'DBMS';
      case ActivityType.englishPractice:
        return 'English Practice';
      case ActivityType.projectWork:
        return 'Project Work';
      case ActivityType.takingBreak:
        return 'Taking Break';
      case ActivityType.instagram:
        return 'Instagram';
      case ActivityType.youtube:
        return 'YouTube';
      case ActivityType.feelingTired:
        return 'Feeling Tired';
      case ActivityType.feelingLow:
        return 'Feeling Low';
      case ActivityType.other:
        return 'Other';
    }
  }

  bool _isFocusedActivity(ActivityType type) {
    return [
      ActivityType.inLecture,
      ActivityType.studying,
      ActivityType.dsa,
      ActivityType.dbms,
      ActivityType.englishPractice,
      ActivityType.projectWork,
    ].contains(type);
  }

  bool _isDistractionActivity(ActivityType type) {
    return [ActivityType.instagram, ActivityType.youtube].contains(type);
  }

  String _getTimePeriod(int hour) {
    if (hour >= 6 && hour < 12) return 'Morning';
    if (hour >= 12 && hour < 17) return 'Afternoon';
    if (hour >= 17 && hour < 21) return 'Evening';
    return 'Night';
  }

  String _moodToString(int rating) {
    switch (rating) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Okay';
      case 4:
        return 'Good';
      case 5:
        return 'Excellent';
      default:
        return 'Neutral';
    }
  }

  String _moodToEmoji(double rating) {
    if (rating <= 1.5) return '😔';
    if (rating <= 2.5) return '😞';
    if (rating <= 3.5) return '😐';
    if (rating <= 4.5) return '🙂';
    return '😄';
  }

  String _energyToEmoji(double rating) {
    if (rating <= 1.5) return '😴';
    if (rating <= 2.5) return '🥱';
    if (rating <= 3.5) return '😐';
    if (rating <= 4.5) return '⚡';
    return '🔥';
  }

  String _getEngagementRating(double avgPerDay) {
    if (avgPerDay >= 8) return '🔥 Excellent';
    if (avgPerDay >= 5) return '⭐ Great';
    if (avgPerDay >= 3) return '👍 Good';
    if (avgPerDay >= 1) return '📈 Building';
    return '🌱 Starting';
  }

  String _generatePositiveFeedback(List<ActivityLog> activities) {
    final faves = _identifyFavoriteActivities(activities);
    final avgMood = _calculateAverageMood(activities);

    return '''
  • Your ${faves.isNotEmpty ? faves.first : 'activity'} frequency shows dedication
  • Your mood trend is ${avgMood >= 3.5 ? 'positive' : 'improving'}
  • You're building consistency through daily check-ins''';
  }

  String _generateChallenge(List<ActivityLog> activities) {
    final distractions = _identifyTopDistractions(activities);
    if (distractions.isEmpty) {
      return 'Try one new focused activity this week!';
    }
    return 'Reduce ${distractions.first} time by 30% this week. You\'ve got this! 💪';
  }
}
