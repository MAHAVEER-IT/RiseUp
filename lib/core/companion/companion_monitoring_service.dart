import 'package:riseup/core/notifications/notification_service.dart';
import 'package:riseup/features/companion/repositories/activity_repository.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'dart:async';

class CompanionMonitoringService {
  final ActivityRepository _activityRepository;

  // Companion check-in messages (caring, not pushy)
  static const List<String> companionMessages = [
    'How are things going?',
    'What are you focused on?',
    'Need a quick reset?',
    'What\'s happening right now?',
    'How\'s your energy?',
    'Taking care of yourself?',
    'What\'s on your mind?',
    'Quick update - what are you doing?',
  ];

  Timer? _checkInTimer;

  CompanionMonitoringService(this._activityRepository);

  /// Check if today is a college day or holiday
  bool _isCollegeDay(DateTime date) {
    // 0 = Monday, 1 = Tuesday, ..., 5 = Saturday, 6 = Sunday
    final weekday = date.weekday;
    // Assume college days are Mon-Fri (1-5)
    return weekday >= 1 && weekday <= 5;
  }

  /// Get active hours based on day type
  DateTimeRange _getActiveHours(DateTime date) {
    if (_isCollegeDay(date)) {
      // College Days: 7:00 AM - 10:00 PM
      return DateTimeRange(
        start: DateTime(date.year, date.month, date.day, 7, 0),
        end: DateTime(date.year, date.month, date.day, 22, 0),
      );
    } else {
      // Holiday Days: 8:00 AM - 10:00 PM
      return DateTimeRange(
        start: DateTime(date.year, date.month, date.day, 8, 0),
        end: DateTime(date.year, date.month, date.day, 22, 0),
      );
    }
  }

  /// Schedule daily companion check-ins
  Future<void> scheduleCompanionCheckIns() async {
    final today = DateTime.now();
    final activeHours = _getActiveHours(today);

    // Schedule notifications every 1-2 hours during active hours
    // For simplicity, we'll schedule at 1-hour intervals
    DateTime currentTime = activeHours.start;
    int notificationId = 1000; // Start IDs at 1000 for companion notifications

    while (currentTime.isBefore(activeHours.end)) {
      final message =
          companionMessages[notificationId % companionMessages.length];

      await NotificationService.scheduleNotification(
        title: 'RiseUp Check-in',
        body: message,
        id: notificationId,
        scheduledTime: currentTime,
      );

      // Move to next hour
      currentTime = currentTime.add(const Duration(hours: 1));
      notificationId++;
    }
  }

  /// Save activity response from user
  Future<int> saveActivityResponse({
    required String activityType,
    String? additionalNote,
  }) async {
    final activity = ActivityLog()
      ..timestamp = DateTime.now()
      ..activity = _parseActivityType(activityType)
      ..additionalNote = additionalNote;

    await _activityRepository.saveActivity(activity);
    return activity.id;
  }

  /// Parse activity type from string
  ActivityType _parseActivityType(String type) {
    switch (type) {
      case 'In Lecture':
        return ActivityType.inLecture;
      case 'Studying':
        return ActivityType.studying;
      case 'DSA':
        return ActivityType.dsa;
      case 'DBMS':
        return ActivityType.dbms;
      case 'English Practice':
        return ActivityType.englishPractice;
      case 'Project Work':
        return ActivityType.projectWork;
      case 'Taking Break':
        return ActivityType.takingBreak;
      case 'Instagram':
        return ActivityType.instagram;
      case 'YouTube':
        return ActivityType.youtube;
      case 'Feeling Tired':
        return ActivityType.feelingTired;
      case 'Feeling Low':
        return ActivityType.feelingLow;
      case 'Other':
        return ActivityType.other;
      default:
        return ActivityType.other;
    }
  }

  /// Get activity type name from enum
  String getActivityName(ActivityType type) {
    switch (type) {
      case ActivityType.inLecture:
        return 'In Lecture';
      case ActivityType.studying:
        return 'Studying';
      case ActivityType.dsa:
        return 'DSA';
      case ActivityType.dbms:
        return 'DBMS';
      case ActivityType.englishPractice:
        return 'English Practice';
      case ActivityType.projectWork:
        return 'Project Work';
      case ActivityType.takingBreak:
        return 'Taking Break';
      case ActivityType.instagram:
        return 'Instagram';
      case ActivityType.youtube:
        return 'YouTube';
      case ActivityType.feelingTired:
        return 'Feeling Tired';
      case ActivityType.feelingLow:
        return 'Feeling Low';
      case ActivityType.other:
        return 'Other';
    }
  }

  /// Get activity emoji
  String getActivityEmoji(ActivityType type) {
    switch (type) {
      case ActivityType.inLecture:
        return '🎓';
      case ActivityType.studying:
        return '📚';
      case ActivityType.dsa:
        return '🔢';
      case ActivityType.dbms:
        return '🗄️';
      case ActivityType.englishPractice:
        return '🗣️';
      case ActivityType.projectWork:
        return '💻';
      case ActivityType.takingBreak:
        return '☕';
      case ActivityType.instagram:
        return '📱';
      case ActivityType.youtube:
        return '📺';
      case ActivityType.feelingTired:
        return '😴';
      case ActivityType.feelingLow:
        return '😔';
      case ActivityType.other:
        return '✍️';
    }
  }

  /// Static helper to get activity name
  static String getActivityNameStatic(ActivityType type) {
    switch (type) {
      case ActivityType.inLecture:
        return 'In Lecture';
      case ActivityType.studying:
        return 'Studying';
      case ActivityType.dsa:
        return 'DSA';
      case ActivityType.dbms:
        return 'DBMS';
      case ActivityType.englishPractice:
        return 'English Practice';
      case ActivityType.projectWork:
        return 'Project Work';
      case ActivityType.takingBreak:
        return 'Taking Break';
      case ActivityType.instagram:
        return 'Instagram';
      case ActivityType.youtube:
        return 'YouTube';
      case ActivityType.feelingTired:
        return 'Feeling Tired';
      case ActivityType.feelingLow:
        return 'Feeling Low';
      case ActivityType.other:
        return 'Other';
    }
  }

  /// Static helper to get activity emoji
  static String getActivityEmojiStatic(ActivityType type) {
    switch (type) {
      case ActivityType.inLecture:
        return '🎓';
      case ActivityType.studying:
        return '📚';
      case ActivityType.dsa:
        return '🔢';
      case ActivityType.dbms:
        return '🗄️';
      case ActivityType.englishPractice:
        return '🗣️';
      case ActivityType.projectWork:
        return '💻';
      case ActivityType.takingBreak:
        return '☕';
      case ActivityType.instagram:
        return '📱';
      case ActivityType.youtube:
        return '📺';
      case ActivityType.feelingTired:
        return '😴';
      case ActivityType.feelingLow:
        return '😔';
      case ActivityType.other:
        return '✍️';
    }
  }

  void dispose() {
    _checkInTimer?.cancel();
  }
}

class DateTimeRange {
  final DateTime start;
  final DateTime end;

  DateTimeRange({required this.start, required this.end});
}
