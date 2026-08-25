import 'package:isar/isar.dart';

part 'activity_log.g.dart';

enum ActivityType {
  inLecture,
  studying,
  dsa,
  dbms,
  englishPractice,
  projectWork,
  takingBreak,
  instagram,
  youtube,
  feelingTired,
  feelingLow,
  other,
}

@collection
class ActivityLog {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime timestamp;

  @enumerated
  late ActivityType activity;

  String? additionalNote;

  // User mood and energy tracking (1-5 scale)
  int? moodRating;
  int? energyLevel;

  // AI response from Gemini
  String? aiEncouragement;
  String? aiSuggestion;
  String? aiFocusGuidance;

  bool aiResponseGenerated = false;
}
