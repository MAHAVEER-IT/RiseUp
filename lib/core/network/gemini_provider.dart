import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/gemini_service.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  const apiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: 'AIzaSyCPIN64uRp91bB4jjJp3PCCMGeCrPAMJ7w',
  );
  return GeminiService(apiKey);
});
