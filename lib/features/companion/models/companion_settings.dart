import 'package:isar/isar.dart';
import 'package:riseup/features/companion/models/companion_mode.dart';

part 'companion_settings.g.dart';

@collection
class CompanionSettings {
  Id id = Isar.autoIncrement;

  // Companion mode (light/balanced/active)
  late String mode; // Stored as string for Isar compatibility

  // Quiet hours configuration
  late bool quietHoursEnabled;
  late int quietHoursStart; // 24-hour format (0-23)
  late int quietHoursEnd; // 24-hour format (0-23)

  // Check-in notification settings
  late bool notificationsEnabled;
  late bool soundEnabled;
  late bool vibrationEnabled;

  // Personalization
  late bool useFormalTone;
  late bool trackMood;
  late bool trackEnergy;

  // Advanced settings
  late bool autoReduceFrequencyOnIgnore;
  late int minimumGapBetweenCheckInsMinutes; // Minimum 60 minutes
  late bool enableWeeklyInsights;

  // Metadata
  late DateTime createdAt;
  late DateTime updatedAt;

  /// Helper: Get companion mode enum
  @ignore
  CompanionMode get companionMode {
    switch (mode) {
      case 'light':
        return CompanionMode.light;
      case 'active':
        return CompanionMode.active;
      default:
        return CompanionMode.balanced;
    }
  }

  /// Helper: Set companion mode
  void setCompanionMode(CompanionMode newMode) {
    mode = newMode.toString().split('.').last;
    updatedAt = DateTime.now();
  }

  /// Factory constructor with defaults
  static CompanionSettings createDefault() {
    final now = DateTime.now();
    return CompanionSettings()
      ..mode = 'balanced'
      ..quietHoursEnabled = true
      ..quietHoursStart =
          22 // 10 PM
      ..quietHoursEnd =
          7 // 7 AM
      ..notificationsEnabled = true
      ..soundEnabled = true
      ..vibrationEnabled = true
      ..useFormalTone = false
      ..trackMood = true
      ..trackEnergy = true
      ..autoReduceFrequencyOnIgnore = true
      ..minimumGapBetweenCheckInsMinutes = 60
      ..enableWeeklyInsights = true
      ..createdAt = now
      ..updatedAt = now;
  }

  /// Check if current time is within quiet hours
  bool isInQuietHours(DateTime dateTime) {
    if (!quietHoursEnabled) return false;

    final hour = dateTime.hour;

    if (quietHoursStart < quietHoursEnd) {
      // Normal case: 22:00 - 07:00 wraps to next day
      return hour >= quietHoursStart || hour < quietHoursEnd;
    } else {
      // Edge case: quiet hours don't wrap
      return hour >= quietHoursStart && hour < quietHoursEnd;
    }
  }
}
