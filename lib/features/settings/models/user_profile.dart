import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  late String name;

  late DateTime wakeTime;
  late DateTime sleepTime;
  late DateTime collegeStartTime;
  late DateTime collegeEndTime;

  late DateTime createdAt;
  late DateTime lastUpdatedAt;
}
