import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/features/settings/models/user_profile.dart';
import 'package:riseup/features/settings/repositories/user_profile_repository.dart';

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return UserProfileRepository(isar);
});

final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile>(() {
      return UserProfileNotifier();
    });

class UserProfileNotifier extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() async {
    return ref.watch(userProfileRepositoryProvider).getOrCreateProfile();
  }

  Future<void> updateProfile(UserProfile profile) async {
    final repository = ref.read(userProfileRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      profile.lastUpdatedAt = DateTime.now();
      await repository.saveUserProfile(profile);
      return profile;
    });
  }
}
