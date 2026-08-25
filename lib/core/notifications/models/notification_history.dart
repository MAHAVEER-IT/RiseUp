import 'package:isar/isar.dart';

part 'notification_history.g.dart';

enum NotificationType {
  morning,
  commute,
  evening,
  bedtime,
  milestone,
  companionCheckIn,
}

@collection
class NotificationHistory {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime timestamp;

  @enumerated
  late NotificationType type;

  late bool triggered;

  String? message;
}
