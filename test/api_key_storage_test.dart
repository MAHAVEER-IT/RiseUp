import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riseup/core/storage/api_key_storage_service.dart';

import 'package:riseup/core/network/gemini_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiKeyStorageService tests', () {
    late ApiKeyStorageService service;

    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      service = ApiKeyStorageService(storage: const FlutterSecureStorage());
    });

    test('returns null when no key is set', () async {
      final key = await service.getApiKey();
      expect(key, isNull);

      final hasKey = await service.hasApiKey();
      expect(hasKey, isFalse);
    });

    test('saves and retrieves an API key correctly', () async {
      await service.saveApiKey('  AIzaSyTestApiKey12345  ');

      final key = await service.getApiKey();
      expect(key, equals('AIzaSyTestApiKey12345'));

      final hasKey = await service.hasApiKey();
      expect(hasKey, isTrue);
    });

    test('deletes an API key successfully', () async {
      await service.saveApiKey('AIzaSyTestKey');
      expect(await service.hasApiKey(), isTrue);

      await service.deleteApiKey();
      expect(await service.getApiKey(), isNull);
      expect(await service.hasApiKey(), isFalse);
    });
  });

  group('GeminiService validation status tests', () {
    test('returns invalid for empty or whitespace-only key', () async {
      expect(await GeminiService.testApiKey(''), equals(ApiKeyValidationStatus.invalid));
      expect(await GeminiService.testApiKey('   '), equals(ApiKeyValidationStatus.invalid));
    });

    test('ApiKeyValidationStatus contains valid, serverBusy, and invalid', () {
      expect(ApiKeyValidationStatus.values, containsAll([
        ApiKeyValidationStatus.valid,
        ApiKeyValidationStatus.serverBusy,
        ApiKeyValidationStatus.invalid,
      ]));
    });
  });
}

