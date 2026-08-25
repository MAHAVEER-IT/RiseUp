import 'package:isar/isar.dart';
import '../models/user_profile.dart';

class UserProfileRepository {
  final Isar isar;

  UserProfileRepository(this.isar);

  Future<UserProfile?> getUserProfile() async {
    return await isar.userProfiles.where().findFirst();
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    await isar.writeTxn(() async {
      await isar.userProfiles.put(profile);
    });
  }

  Future<UserProfile> getOrCreateProfile() async {
    var profile = await getUserProfile();
    if (profile == null) {
      profile = UserProfile()
        ..name = 'User'
        ..wakeTime = DateTime(2000, 1, 1, 6, 0)
        ..sleepTime = DateTime(2000, 1, 1, 23, 0)
        ..collegeStartTime = DateTime(2000, 1, 1, 8, 45)
        ..collegeEndTime = DateTime(2000, 1, 1, 16, 10)
        ..createdAt = DateTime.now()
        ..lastUpdatedAt = DateTime.now();
      await saveUserProfile(profile);
    }
    return profile;
  }
}
