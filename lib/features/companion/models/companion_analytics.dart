import 'package:isar/isar.dart';

part 'companion_analytics.g.dart';

@collection
class CompanionAnalytics {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date; // Date of analytics

  // Activity tracking
  late int totalCheckIns; // Total check-ins responded to
  late int ignoredCheckIns; // Check-ins ignored

  // Most common activities (activity type name -> count)
  @ignore
  late Map<String, int> activityFrequency;

  // Mood tracking
  @ignore
  late Map<String, int> moodFrequency; // mood -> count

  // Energy levels (1-5 scale)
  @ignore
  late Map<int, int> energyLevels; // level -> count

  // Time of day analysis
  @ignore
  late Map<String, int> activityByTimeOfDay; // "morning"/"afternoon"/"evening"/"night" -> count

  // Best focus hours (hour -> success rate 0-100)
  @ignore
  late Map<int, int> focusHourSuccessRate;

  // Distraction patterns
  late List<String> topDistractions = []; // Most common distraction activities

  // English practice tracking
  late int englishPracticeSessions = 0;
  late int englishPracticeMinutes = 0;

  // Engagement metrics
  late double engagementScore = 0.0; // 0-100, based on check-in response rate
  late DateTime lastEngagedAt = DateTime.now();

  // Personalization data
  late List<String> favoriteActivities = [];
  late List<String> commonNotes = [];
  @ignore
  late Map<String, String> personalizedTips = {}; // activity -> custom tip
}
