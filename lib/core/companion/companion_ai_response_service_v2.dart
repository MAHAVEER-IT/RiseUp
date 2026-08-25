import 'package:riseup/core/network/gemini_service.dart';
import 'package:riseup/features/companion/repositories/activity_repository.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'package:riseup/core/companion/companion_message_service.dart';

class CompanionAIResponseServiceV2 {
  final GeminiService _geminiService;
  final ActivityRepository _activityRepository;

  CompanionAIResponseServiceV2({
    required GeminiService geminiService,
    required ActivityRepository activityRepository,
  }) : _geminiService = geminiService,
       _activityRepository = activityRepository;

  /// Generate personalized AI response with full context
  Future<Map<String, String>> generateCompanionResponse({
    required String activityType,
    String? additionalNote,
    int? moodRating,
    int? energyLevel,
  }) async {
    try {
      // Build rich context from user's patterns
      final context = await _buildPersonalizedContext(
        activityType: activityType,
        additionalNote: additionalNote,
        moodRating: moodRating,
        energyLevel: energyLevel,
      );

      // Call Gemini with context-aware prompt
      final response = await _geminiService.prompt(
        _buildCompanionPrompt(context),
        '',
      );

      return _parseCompanionResponse(response);
    } catch (e) {
      return _getDefaultResponse(activityType, moodRating, energyLevel);
    }
  }

  /// Build rich context from user's activity history
  Future<String> _buildPersonalizedContext({
    required String activityType,
    String? additionalNote,
    int? moodRating,
    int? energyLevel,
  }) async {
    // Get recent activities
    final todayActivities = await _activityRepository.getActivitiesForToday();
    final recentActivities = await _activityRepository.getActivitiesForLastDays(
      7,
    );

    // Calculate patterns
    final timeOfDay = CompanionMessageService.getTimePeriodName(
      DateTime.now().hour,
    );
    final averageMood = todayActivities.isEmpty
        ? 3
        : _calculateAverageMood(todayActivities);
    final averageEnergy = todayActivities.isEmpty
        ? 3
        : _calculateAverageEnergy(todayActivities);

    // Activity patterns
    final activityCounts = _countActivities(recentActivities);
    final mostCommon = activityCounts.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );

    // Engagement streak
    final engagementDays = _calculateEngagementStreak(recentActivities);

    return '''
CURRENT CONTEXT:
- Time of Day: $timeOfDay
- Current Activity: $activityType
- User Note: ${additionalNote ?? "None"}
- Current Mood: ${_moodDescription(moodRating ?? 3)}/5
- Current Energy: ${_energyDescription(energyLevel ?? 3)}/5

USER PATTERNS (Last 7 Days):
- Total Check-ins: ${recentActivities.length}
- Most Common Activity: ${mostCommon.key}
- Average Mood: ${_moodDescription(averageMood)}/5
- Average Energy: ${_energyDescription(averageEnergy)}/5
- Engagement Streak: $engagementDays days

TODAY'S ACTIVITIES (${todayActivities.length} check-ins):
${_formatTodayActivities(todayActivities)}
''';
  }

  /// Build the Gemini system prompt for companion responses
  String _buildCompanionPrompt(String context) {
    return '''You are a caring, empathetic AI companion designed to support a student.

$context

GUIDELINES:
1. Be genuinely compassionate, not just motivational.
2. Acknowledge their current state without judgment.
3. Provide specific, actionable suggestions tailored to their activity.
4. Keep responses concise (2-3 sentences max).
5. Avoid generic productivity tips.
6. Personalize based on their patterns and mood.

RESPONSE FORMAT (JSON):
{
  "encouragement": "Genuine, warm support relevant to their situation",
  "guidance": "What they could do next (activity-specific)",
  "focusGuidance": "If studying/working, how to sustain momentum"
}

EXAMPLES:

If activity is "Instagram":
{
  "encouragement": "Taking a break is healthy. Make sure you're taking care of yourself.",
  "guidance": "You've been on social media for a bit. When you're ready, could you try 10 minutes of English practice?",
  "focusGuidance": "Even a quick 10-min session builds momentum."
}

If activity is "DSA" with low energy:
{
  "encouragement": "Your consistency with DSA is impressive. You don't need perfection, just progress.",
  "guidance": "Since your energy is low, try an easier problem or review previous concepts.",
  "focusGuidance": "Quality over quantity. 20 minutes focused beats 2 hours scattered."
}

If activity is "Feeling Low":
{
  "encouragement": "Difficult moments are part of growth. You're reaching out and that matters.",
  "guidance": "Let's focus on one small thing you can do right now: a 5-minute walk, water, or chat.",
  "focusGuidance": "You don't need to fix everything today. One small step is enough."
}

Now respond with JSON for the current activity.''';
  }

  /// Parse and validate Gemini response
  Map<String, String> _parseCompanionResponse(String response) {
    try {
      // Extract JSON from response
      final jsonStart = response.indexOf('{');
      final jsonEnd = response.lastIndexOf('}') + 1;

      if (jsonStart == -1 || jsonEnd <= jsonStart) {
        return _getDefaultResponse('Activity', null, null);
      }

      final jsonStr = response.substring(jsonStart, jsonEnd);

      // Basic JSON parsing (in production, use json package)
      return {
        'encouragement': _extractField(jsonStr, 'encouragement'),
        'guidance': _extractField(jsonStr, 'guidance'),
        'focusGuidance': _extractField(jsonStr, 'focusGuidance'),
      };
    } catch (e) {
      return _getDefaultResponse('Activity', null, null);
    }
  }

  /// Extract JSON field value
  String _extractField(String jsonStr, String fieldName) {
    try {
      final regex = RegExp('"$fieldName"\\s*:\\s*"([^"]*)"');
      final match = regex.firstMatch(jsonStr);
      return match?.group(1) ?? '';
    } catch (e) {
      return '';
    }
  }

  /// Get default response based on activity and mood
  Map<String, String> _getDefaultResponse(
    String activity,
    int? moodRating,
    int? energyLevel,
  ) {
    final isFeelingLow = activity.contains('Feeling Low');
    final isFeelingTired = activity.contains('Feeling Tired');
    final isDistraction = ['Instagram', 'YouTube'].contains(activity);
    final isStudying = [
      'Studying',
      'DSA',
      'DBMS',
      'English Practice',
    ].any((a) => activity.contains(a));

    if (isFeelingLow) {
      return {
        'encouragement':
            '💙 It\'s okay to have difficult days. You reaching out matters.',
        'guidance':
            'Let\'s focus on one small thing: a 5-minute walk, water, or rest.',
        'focusGuidance':
            'You don\'t need to fix everything today. One small step is enough.',
      };
    }

    if (isFeelingTired) {
      return {
        'encouragement':
            '😴 Rest is productive. You\'re taking care of yourself.',
        'guidance': 'Listen to your body. A 15-minute nap or break might help.',
        'focusGuidance': 'Come back when you\'re refreshed. Quality matters.',
      };
    }

    if (isDistraction) {
      return {
        'encouragement':
            'Breaks are important. Taking time for yourself is healthy.',
        'guidance':
            'When you\'re ready, could you try 10 minutes of focused work?',
        'focusGuidance': 'Even a quick session builds momentum.',
      };
    }

    if (isStudying) {
      return {
        'encouragement': '📚 Your dedication is impressive. Keep going.',
        'guidance':
            'You\'re on a roll. Stay focused for another 20-30 minutes.',
        'focusGuidance': 'Break it into smaller chunks if you need a pause.',
      };
    }

    return {
      'encouragement': '💙 I\'m here for you.',
      'guidance': 'What would help you most right now?',
      'focusGuidance': 'You\'re doing great.',
    };
  }

  // Helper methods
  int _calculateAverageMood(List<ActivityLog> activities) {
    final validMoods = activities
        .where((a) => a.moodRating != null)
        .map((a) => a.moodRating!)
        .toList();
    if (validMoods.isEmpty) return 3;
    return (validMoods.reduce((a, b) => a + b) / validMoods.length).round();
  }

  int _calculateAverageEnergy(List<ActivityLog> activities) {
    final validEnergy = activities
        .where((a) => a.energyLevel != null)
        .map((a) => a.energyLevel!)
        .toList();
    if (validEnergy.isEmpty) return 3;
    return (validEnergy.reduce((a, b) => a + b) / validEnergy.length).round();
  }

  Map<String, int> _countActivities(List<ActivityLog> activities) {
    final counts = <String, int>{};
    for (final activity in activities) {
      final name = getActivityNameStatic(activity.activity);
      counts[name] = (counts[name] ?? 0) + 1;
    }
    return counts;
  }

  int _calculateEngagementStreak(List<ActivityLog> activities) {
    if (activities.isEmpty) return 0;

    var streak = 0;
    final today = DateTime.now();

    for (int i = 0; i < 30; i++) {
      final date = DateTime(today.year, today.month, today.day - i);
      final hasActivity = activities.any(
        (a) =>
            a.timestamp.year == date.year &&
            a.timestamp.month == date.month &&
            a.timestamp.day == date.day,
      );

      if (hasActivity) {
        streak++;
      } else if (i > 0) {
        break;
      }
    }

    return streak;
  }

  String _formatTodayActivities(List<ActivityLog> activities) {
    if (activities.isEmpty) return 'No activities yet today.';

    final grouped = <String, int>{};
    for (final activity in activities) {
      final name = getActivityNameStatic(activity.activity);
      grouped[name] = (grouped[name] ?? 0) + 1;
    }

    return grouped.entries
        .map((e) => '- ${e.key}: ${e.value} time(s)')
        .join('\n');
  }

  String _moodDescription(int rating) {
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

  String _energyDescription(int level) {
    switch (level) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Moderate';
      case 4:
        return 'High';
      case 5:
        return 'Very High';
      default:
        return 'Moderate';
    }
  }

  static String getActivityNameStatic(ActivityType type) {
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
}
