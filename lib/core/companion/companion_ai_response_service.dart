import 'package:riseup/core/network/gemini_service.dart';

class CompanionAIResponseService {
  final GeminiService _geminiService;

  CompanionAIResponseService(this._geminiService);

  /// Generate AI response for user activity
  Future<Map<String, String>> generateCompanionResponse({
    required String activityType,
    String? additionalNote,
    required List<Map<String, dynamic>> recentActivities,
  }) async {
    try {
      final context = _buildActivityContext(
        activityType: activityType,
        additionalNote: additionalNote,
        recentActivities: recentActivities,
      );

      final systemPrompt =
          '''
You are RiseUp, a caring AI companion supporting your growth journey.

The user just told you: "$activityType"
${additionalNote != null ? 'Additional note: "$additionalNote"' : ''}

Your response should:
1. Be warm, understanding, and non-judgmental
2. Acknowledge what they're doing
3. Provide ONE actionable encouragement
4. Include a recovery suggestion if needed
5. Give focus guidance if studying/working
6. Keep it brief (2-3 sentences max)

Format your response as JSON with keys:
- "encouragement": Warm acknowledgment (1 sentence)
- "suggestion": Actionable recovery/help (1 sentence)
- "focusGuidance": Focus tip if applicable (1 sentence)
''';

      final response = await _geminiService.prompt(systemPrompt, context);
      return _parseCompanionResponse(response);
    } catch (e) {
      return _getDefaultResponse(activityType);
    }
  }

  /// Build activity context for Gemini
  String _buildActivityContext({
    required String activityType,
    String? additionalNote,
    required List<Map<String, dynamic>> recentActivities,
  }) {
    final activitySummary = _summarizeActivities(recentActivities);

    return '''
User's Current Activity: $activityType
${additionalNote != null ? 'Note: $additionalNote' : ''}

Today's Activity Pattern:
$activitySummary

Time: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}
''';
  }

  /// Summarize recent activities for context
  String _summarizeActivities(List<Map<String, dynamic>> activities) {
    if (activities.isEmpty) {
      return 'No previous activities logged today.';
    }

    final summary = activities
        .take(5)
        .map((activity) {
          final type = activity['type'] as String?;
          final time = activity['time'] as String?;
          return '- $type at $time';
        })
        .join('\n');

    return summary;
  }

  /// Parse Gemini response
  Map<String, String> _parseCompanionResponse(String response) {
    try {
      // Try to extract JSON from response
      final jsonStart = response.indexOf('{');
      final jsonEnd = response.lastIndexOf('}');

      if (jsonStart != -1 && jsonEnd != -1) {
        final jsonStr = response.substring(jsonStart, jsonEnd + 1);
        // Parse JSON-like response (simplified)
        return {
          'encouragement': _extractField(jsonStr, 'encouragement'),
          'suggestion': _extractField(jsonStr, 'suggestion'),
          'focusGuidance': _extractField(jsonStr, 'focusGuidance'),
        };
      }
    } catch (e) {
      // Error parsing response - return default
    }

    return _getDefaultResponse('Activity');
  }

  /// Extract field from JSON-like string
  String _extractField(String json, String field) {
    final pattern = '"$field"\\s*:\\s*"([^"]*)"';
    final regex = RegExp(pattern);
    final match = regex.firstMatch(json);
    return match?.group(1) ?? '';
  }

  /// Get default response when Gemini fails
  Map<String, String> _getDefaultResponse(String activityType) {
    final defaults = {
      'inLecture': {
        'encouragement': 'Great! Active learning is key to growth. 🎓',
        'suggestion': 'Stay engaged - take quick notes or ask questions.',
        'focusGuidance': 'Focus on understanding the concepts, not memorizing.',
      },
      'studying': {
        'encouragement': 'Love the dedication! You\'re building momentum. 📚',
        'suggestion': 'Take a 5-min break every 25 minutes to recharge.',
        'focusGuidance': 'Break complex topics into smaller chunks.',
      },
      'dsa': {
        'encouragement': 'Data Structures & Algorithms - excellent choice! 🔢',
        'suggestion': 'Practice one problem, then review similar ones.',
        'focusGuidance': 'Understand the pattern before coding the solution.',
      },
      'dbms': {
        'encouragement':
            'DBMS concepts are crucial - you\'re investing well! 🗄️',
        'suggestion': 'Draw ER diagrams to visualize the relationships.',
        'focusGuidance': 'Learn theory first, then practice with queries.',
      },
      'englishPractice': {
        'encouragement': 'Building communication skills - awesome! 🗣️',
        'suggestion': 'Record yourself and listen for improvements.',
        'focusGuidance': 'Focus on clarity and confidence.',
      },
      'projectWork': {
        'encouragement':
            'Building real projects - that\'s how learning sticks! 💻',
        'suggestion':
            'Break it into smaller features and tackle one at a time.',
        'focusGuidance': 'Implement, test, then refactor.',
      },
      'takingBreak': {
        'encouragement': 'Rest is productive! You deserve this break. ☕',
        'suggestion': 'Stretch, hydrate, or take a short walk.',
        'focusGuidance': 'Come back refreshed with renewed focus.',
      },
      'instagram': {
        'encouragement': 'Staying connected is important too. 📱',
        'suggestion': 'Consider setting a time limit for this session.',
        'focusGuidance': 'Notice how you feel after - adjust as needed.',
      },
      'youtube': {
        'encouragement': 'Learning or unwinding? Both have value. 📺',
        'suggestion': 'If learning, take notes on key takeaways.',
        'focusGuidance': 'Be intentional about your viewing time.',
      },
      'feelingTired': {
        'encouragement': 'Listen to your body - rest is important. 😴',
        'suggestion': 'Get some sleep or take a proper nap.',
        'focusGuidance': 'You\'ll be more productive after recovery.',
      },
      'feelingLow': {
        'encouragement': 'It\'s okay to feel this way - you\'re human. 💙',
        'suggestion': 'Reach out to someone or do something you enjoy.',
        'focusGuidance': 'Gentle activity or talk to a trusted person.',
      },
    };

    return defaults[activityType
            .replaceAll(' ', '')
            .replaceAll('/', '')
            .toLowerCase()] ??
        {
          'encouragement': 'You\'re doing great! Keep going. 💪',
          'suggestion': 'Whatever you\'re doing, do it with intention.',
          'focusGuidance': 'Stay present in the moment.',
        };
  }
}
