import 'package:isar/isar.dart';

part 'english_practice_speaking_log.g.dart';

enum PracticeMedium {
  conversation, // Speaking with friend/native speaker
  videoCall, // Video call practice
  voiceRecording, // Recording and playback
  monologue, // Speaking alone/self-practice
  classroom, // Classroom/structured lesson
  other,
}

@collection
class EnglishPracticeSpeakingLog {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime timestamp;

  late int durationMinutes;

  @enumerated
  late PracticeMedium medium;

  String?
  topic; // What was practiced (e.g., "Business conversations", "Storytelling")

  String? notes; // Reflection notes

  @Index()
  late DateTime createdAt;

  // Self-assessment (1-5 scale)
  int? fluencyRating; // 1=Struggled, 5=Smooth and natural
  int? confidenceRating; // 1=Very nervous, 5=Very confident
  int? comprensionRating; // 1=Didn't understand, 5=Understood perfectly

  // Streak tracking
  int streakDays = 0;

  EnglishPracticeSpeakingLog({
    required this.timestamp,
    required this.durationMinutes,
    required this.medium,
    this.topic,
    this.notes,
    this.fluencyRating,
    this.confidenceRating,
    this.comprensionRating,
    this.streakDays = 0,
  }) {
    createdAt = DateTime.now();
  }
}
