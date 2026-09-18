import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/network/gemini_service.dart';
import 'package:riseup/core/storage/api_key_storage_service.dart';

final apiKeyStorageServiceProvider = Provider<ApiKeyStorageService>((ref) {
  return ApiKeyStorageService();
});

final geminiApiKeyProvider =
    AsyncNotifierProvider<GeminiApiKeyNotifier, String?>(() {
  return GeminiApiKeyNotifier();
});

class GeminiApiKeyNotifier extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async {
    final storage = ref.read(apiKeyStorageServiceProvider);
    return await storage.getApiKey();
  }

  Future<void> setApiKey(String key) async {
    final storage = ref.read(apiKeyStorageServiceProvider);
    final cleanKey = key.trim();
    await storage.saveApiKey(cleanKey);
    state = AsyncValue.data(cleanKey);
  }

  Future<void> removeApiKey() async {
    final storage = ref.read(apiKeyStorageServiceProvider);
    await storage.deleteApiKey();
    state = const AsyncValue.data(null);
  }
}

final hasGeminiKeyProvider = Provider<bool>((ref) {
  final keyAsync = ref.watch(geminiApiKeyProvider);
  return keyAsync.maybeWhen(
    data: (key) => key != null && key.trim().isNotEmpty,
    orElse: () => false,
  );
});

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final key = ref.watch(geminiApiKeyProvider).maybeWhen(
    data: (key) => key ?? '',
    orElse: () => '',
  );
  return GeminiService(key);
});
