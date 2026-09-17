import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey;
  late GenerativeModel _model;

  GeminiService(this.apiKey) {
    _model = GenerativeModel(model: 'gemini-3.6-flash', apiKey: apiKey);
  }

  bool get _isConfigured => apiKey.trim().isNotEmpty;

  static const String _configurationMessage =
      'AI features are not configured in this build. Please contact support.';

  Future<String> prompt(String context, String userMessage) async {
    if (!_isConfigured) return _configurationMessage;
    try {
      final content = [Content.text(context + '\n\nUser: ' + userMessage)];

      final response = await _model.generateContent(content);
      return response.text ??
          'I couldn\'t generate a response. Please try again.';
    } catch (e) {
      return 'An error occurred: $e';
    }
  }

  Future<String> promptChat({
    required String context,
    required List<String> history,
    required String userMessage,
  }) async {
    if (!_isConfigured) return _configurationMessage;
    try {
      final historyContent = history.isNotEmpty
          ? 'Recent Chat History:\n' + history.join('\n') + '\n\n'
          : '';

      final fullPrompt = context + '\n\n' + historyContent + 'User: ' + userMessage;
      final content = [Content.text(fullPrompt)];

      final response = await _model.generateContent(content);
      return response.text ??
          'I couldn\'t generate a response. Please try again.';
    } catch (e) {
      return 'An error occurred: $e';
    }
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

      final content = [Content.text(systemPrompt + '\n\n' + weeklyData)];

      final response = await _model.generateContent(content);
      return response.text ??
          'I couldn\'t generate your weekly review. Try again next week!';
    } catch (e) {
      return 'Weekly review generation encountered an issue: $e. I\'ll try again next week!';
    }
  }
}
