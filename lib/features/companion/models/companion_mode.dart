/// Companion monitoring intensity levels
enum CompanionMode {
  light, // Check-in every 3 hours
  balanced, // Check-in every 2 hours
  active, // Check-in every 1 hour
}

extension CompanionModeExtension on CompanionMode {
  String get displayName {
    switch (this) {
      case CompanionMode.light:
        return 'Light';
      case CompanionMode.balanced:
        return 'Balanced';
      case CompanionMode.active:
        return 'Active';
    }
  }

  String get description {
    switch (this) {
      case CompanionMode.light:
        return 'Check-in every 3 hours';
      case CompanionMode.balanced:
        return 'Check-in every 2 hours';
      case CompanionMode.active:
        return 'Check-in every 1 hour';
    }
  }

  /// Get interval duration in minutes
  int get intervalMinutes {
    switch (this) {
      case CompanionMode.light:
        return 180; // 3 hours
      case CompanionMode.balanced:
        return 120; // 2 hours
      case CompanionMode.active:
        return 60; // 1 hour
    }
  }
}
