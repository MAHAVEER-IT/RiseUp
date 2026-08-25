import 'package:riseup/core/notifications/notification_service.dart';
import 'package:riseup/core/companion/companion_message_service.dart';
import 'package:riseup/features/companion/repositories/activity_repository.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'package:riseup/features/companion/models/companion_settings.dart';
import 'package:riseup/features/companion/models/time_window_config.dart';
import 'dart:async';

class CompanionMonitoringService {
  final ActivityRepository _activityRepository;
  final CompanionSettings settings;

  Timer? _checkInTimer;
  DateTime? _lastCheckInTime;
  int _consecutiveIgnoredCheckIns = 0;

  CompanionMonitoringService({
    required this.settings,
    required ActivityRepository activityRepository,
  }) : _activityRepository = activityRepository;

  /// Schedule smart companion check-ins based on user settings
  Future<void> scheduleSmartCheckIns() async {
    final today = DateTime.now();
    final windows = TimeWindowConfig.getWindowsForDate(today);

    int notificationId = 5000; // Separate ID range for companion checks

    for (final window in windows) {
      // Skip if in quiet hours
      final checkInTime = DateTime(
        today.year,
        today.month,
        today.day,
        window.hour,
        window.minute,
      );

      if (settings.isInQuietHours(checkInTime)) {
        continue;
      }

      // Get contextual message for this time
      final message = CompanionMessageService.getRandomMessageForHour(
        window.hour,
      );

      // Schedule the notification
      await NotificationService.scheduleNotification(
        title: '💙 RiseUp Check-in',
        body: message,
        id: notificationId,
        scheduledTime: checkInTime,
      );

      notificationId++;
    }
  }

  /// Save activity response from user with metadata
  Future<int> saveActivityResponse({
    required String activityType,
    String? additionalNote,
    int? moodRating, // 1-5
    int? energyLevel, // 1-5
  }) async {
    final activity = ActivityLog()
      ..timestamp = DateTime.now()
      ..activity = _parseActivityType(activityType)
      ..additionalNote = additionalNote
      ..moodRating = moodRating
      ..energyLevel = energyLevel;

    await _activityRepository.saveActivity(activity);
    _lastCheckInTime = DateTime.now();
    _consecutiveIgnoredCheckIns = 0; // Reset on engagement

    return activity.id;
  }

  /// Record ignored check-in for fatigue prevention
  Future<void> recordIgnoredCheckIn() async {
    _consecutiveIgnoredCheckIns++;
    _lastCheckInTime = DateTime.now();

    // If too many consecutive ignores, reduce frequency
    if (settings.autoReduceFrequencyOnIgnore &&
        _consecutiveIgnoredCheckIns >= 3) {
      // Could trigger mode reduction logic here
    }
  }

  /// Check if enough time has passed since last check-in
  bool canSendCheckIn() {
    if (_lastCheckInTime == null) return true;

    final minutesSinceLastCheckIn = DateTime.now()
        .difference(_lastCheckInTime!)
        .inMinutes;
    return minutesSinceLastCheckIn >= settings.minimumGapBetweenCheckInsMinutes;
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
