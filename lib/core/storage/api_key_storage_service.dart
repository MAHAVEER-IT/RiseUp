import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiKeyStorageService {
  static const String _geminiApiKeyStorageKey = 'gemini_api_key';

  final FlutterSecureStorage _storage;

  ApiKeyStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  Future<String?> getApiKey() async {
    try {
      final key = await _storage.read(key: _geminiApiKeyStorageKey);
      if (key != null && key.trim().isNotEmpty) {
        return key.trim();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> saveApiKey(String key) async {
    await _storage.write(
      key: _geminiApiKeyStorageKey,
      value: key.trim(),
    );
  }

  Future<void> deleteApiKey() async {
    await _storage.delete(key: _geminiApiKeyStorageKey);
  }

  Future<bool> hasApiKey() async {
    final key = await getApiKey();
    return key != null && key.isNotEmpty;
  }
}
