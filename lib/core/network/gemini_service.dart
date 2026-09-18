import 'package:google_generative_ai/google_generative_ai.dart';

enum ApiKeyValidationStatus {
  valid,
  serverBusy,
  invalid,
}

class GeminiService {
  final String apiKey;

  static const List<String> _candidateModels = [
    'gemini-3.6-flash',
    'gemini-3.5-flash',
    'gemini-3.7-flash',
    'gemini-flash-lite-latest',
  ];

  GeminiService(this.apiKey);

  bool get _isConfigured => apiKey.trim().isNotEmpty;

  static const String _configurationMessage =
      'Please configure your Gemini API key in AI Chat or Settings to use this feature.';

  static Future<ApiKeyValidationStatus> testApiKey(String key) async {
    final cleanKey = key.trim();
    if (cleanKey.isEmpty) return ApiKeyValidationStatus.invalid;

    bool sawServerBusy = false;

    for (final modelName in _candidateModels) {
      try {
        final testModel = GenerativeModel(
          model: modelName,
          apiKey: cleanKey,
        );
        final response = await testModel.generateContent([
          Content.text('Ping'),
        ]);
        if (response.text != null && response.text!.isNotEmpty) {
          return ApiKeyValidationStatus.valid;
        }
      } catch (e) {
        final errStr = e.toString();
        // A 503 / UNAVAILABLE / high demand error means the server is temporarily busy.
        // We do NOT treat this as a valid key. We record it to inform the user that Google is busy.
        if (errStr.contains('503') ||
            errStr.contains('high demand') ||
            errStr.contains('UNAVAILABLE') ||
            errStr.contains('RESOURCE_EXHAUSTED') ||
            errStr.contains('429')) {
          sawServerBusy = true;
        }
        continue;
      }
    }

    if (sawServerBusy) {
      return ApiKeyValidationStatus.serverBusy;
    }

    return ApiKeyValidationStatus.invalid;
  }

  Future<String> _generateWithFallback(List<Content> contents) async {
    Object? lastError;
    for (final modelName in _candidateModels) {
      try {
        final model = GenerativeModel(model: modelName, apiKey: apiKey);
        final response = await model.generateContent(contents);
        if (response.text != null && response.text!.trim().isNotEmpty) {
          return response.text!;
        }
      } catch (e) {
        lastError = e;
        continue;
      }
    }

    if (lastError != null) {
      final errStr = lastError.toString();
      if (errStr.contains('503') ||
          errStr.contains('high demand') ||
          errStr.contains('UNAVAILABLE') ||
          errStr.contains('RESOURCE_EXHAUSTED') ||
          errStr.contains('429') ||
          errStr.contains('quota')) {
        return 'The AI model is currently in high demand. Please try again in a little while.';
      }
      if (errStr.contains('API_KEY_INVALID') ||
          errStr.contains('403') ||
          errStr.contains('401')) {
        return 'Your Gemini API key appears to be invalid or expired. Please check your key in Settings.';
      }
      return 'An unexpected issue occurred. Please try again later.';
    }

    return 'I couldn\'t generate a response. Please try again.';
  }

  Future<String> prompt(String context, String userMessage) async {
    if (!_isConfigured) return _configurationMessage;
    final content = [Content.text('$context\n\nUser: $userMessage')];
    return _generateWithFallback(content);
  }

  Future<String> promptChat({
    required String context,
    required List<String> history,
    required String userMessage,
  }) async {
    if (!_isConfigured) return _configurationMessage;
    final historyContent = history.isNotEmpty
        ? 'Recent Chat History:\n${history.join('\n')}\n\n'
        : '';

    final fullPrompt = '$context\n\n${historyContent}User: $userMessage';
    final content = [Content.text(fullPrompt)];
    return _generateWithFallback(content);
  }

  Future<String> buildContext({
    required String userName,
    required int currentMood,
    required int currentEnergy,
    required String activeGoals,
    required String recentWins,
  }) async {
    return '''
You are RiseUp, an AI personal growth companion for $userName.

Current State:
- Mood: $currentMood/5
- Energy: ${_getEnergyText(currentEnergy)}
- Active Goals: $activeGoals
- Recent Wins: $recentWins

Core Values:
- Never shame or guilt the user
- Celebrate small wins
- Encourage consistency
- Promote healthy sleep
- Provide realistic, actionable advice
- Act as a caring friend, mentor, and accountability partner
''';
  }

  String _getEnergyText(int energy) {
    switch (energy) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Normal';
      case 4:
        return 'High';
      case 5:
        return 'Excellent';
      default:
        return 'Normal';
    }
  }

  Future<String> generateWeeklyInsights(String weeklyData) async {
    if (!_isConfigured) return _configurationMessage;
    try {
      final systemPrompt = '''
You are RiseUp, a compassionate AI coach analyzing someone's week of personal growth.

Your role:
- Celebrate what they accomplished
- Identify patterns (positive and challenging)
- Never shame or guilt about energy drops or missed goals
- Provide ONE actionable suggestion for next week
- Use warm, supportive tone like a trusted friend
- When an important note, pattern, or next action deserves emphasis, wrap only
  that short phrase in double asterisks, like **protect your sleep window**.
- Use bold emphasis sparingly: 1 to 3 emphasized phrases total.

Format your response as a brief, motivating weekly summary. Do not use headings
unless they make the response clearer.
''';

      final content = [Content.text('$systemPrompt\n\n$weeklyData')];
      return _generateWithFallback(content);
    } catch (e) {
      return 'Weekly review generation encountered an issue. I\'ll try again next week!';
    }
  }
}
