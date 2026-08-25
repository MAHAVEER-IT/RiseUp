/// Defines check-in time windows for different day types
class TimeWindowConfig {
  /// College days (Mon-Fri) check-in times
  static const List<TimeOfDay> collegeDayWindows = [
    TimeOfDay(hour: 7, minute: 0), // 7:00 AM
    TimeOfDay(hour: 8, minute: 30), // 8:30 AM
    TimeOfDay(hour: 10, minute: 30), // 10:30 AM
    TimeOfDay(hour: 12, minute: 30), // 12:30 PM
    TimeOfDay(hour: 14, minute: 30), // 2:30 PM
    TimeOfDay(hour: 16, minute: 30), // 4:30 PM
    TimeOfDay(hour: 18, minute: 30), // 6:30 PM
    TimeOfDay(hour: 20, minute: 0), // 8:00 PM
    TimeOfDay(hour: 22, minute: 0), // 10:00 PM
  ];

  /// Holiday days (Sat-Sun) check-in times
  static const List<TimeOfDay> holidayDayWindows = [
    TimeOfDay(hour: 8, minute: 0), // 8:00 AM
    TimeOfDay(hour: 10, minute: 0), // 10:00 AM
    TimeOfDay(hour: 12, minute: 0), // 12:00 PM
    TimeOfDay(hour: 14, minute: 0), // 2:00 PM
    TimeOfDay(hour: 16, minute: 0), // 4:00 PM
    TimeOfDay(hour: 18, minute: 0), // 6:00 PM
    TimeOfDay(hour: 20, minute: 0), // 8:00 PM
    TimeOfDay(hour: 22, minute: 0), // 10:00 PM
  ];

  /// Get check-in windows for a given date
  static List<TimeOfDay> getWindowsForDate(DateTime date) {
    final isCollegeDay = date.weekday >= 1 && date.weekday <= 5;
    return isCollegeDay ? collegeDayWindows : holidayDayWindows;
  }

  /// Get the next scheduled check-in time after given datetime
  static DateTime? getNextCheckInTime(
    DateTime currentTime, {
    required bool isCollegeDay,
  }) {
    final windows = isCollegeDay ? collegeDayWindows : holidayDayWindows;

    // Find next window
    for (final window in windows) {
      final windowDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        window.hour,
        window.minute,
      );

      if (windowDateTime.isAfter(currentTime)) {
        return windowDateTime;
      }
    }

    // If no window found today, return first window tomorrow
    final tomorrow = currentTime.add(const Duration(days: 1));
    final nextWindows = getWindowsForDate(tomorrow);
    return DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      nextWindows.first.hour,
      nextWindows.first.minute,
    );
  }
}

/// Time of day representation
class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  /// Get all time of day windows for a given mode intensity
  static List<TimeOfDay> getWindowsByMode(
    bool isCollegeDay,
    int modeIntervalMinutes,
  ) {
    final baseWindows = isCollegeDay
        ? TimeWindowConfig.collegeDayWindows
        : TimeWindowConfig.holidayDayWindows;

    // If balanced mode (120 min), use all windows
    if (modeIntervalMinutes == 120) {
      return baseWindows;
    }

    // If active mode (60 min), use all windows
    if (modeIntervalMinutes == 60) {
      return baseWindows;
    }

    // If light mode (180 min), filter to every 3 hours
    if (modeIntervalMinutes == 180) {
      return baseWindows.where((w) {
        final totalMinutes = w.hour * 60 + w.minute;
        return totalMinutes % 180 == 0 ||
            [
              7 * 60,
              10 * 60 + 30,
              14 * 60 + 30,
              18 * 60 + 30,
              22 * 60,
            ].contains(totalMinutes);
      }).toList();
    }

    return baseWindows;
  }
}
