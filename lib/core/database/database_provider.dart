import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/wellness/models/daily_check_in.dart';
import '../../features/wellness/models/mood_log.dart';
import '../../features/goals/models/todo.dart';
import '../../features/journal/models/reflection.dart';
import '../../features/progress/models/weekly_review.dart';
import '../../features/journal/models/english_practice_speaking_log.dart';
import '../../features/ai_chat/models/ai_conversation.dart';
import '../../features/ai_chat/models/message.dart';
import '../../features/settings/models/user_profile.dart';
import '../notifications/models/notification_history.dart';
import '../../features/progress/models/achievement.dart';
import '../../features/companion/models/activity_log.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'Isar database must be initialized before accessing isarProvider',
  );
});

class DatabaseProvider {
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([
      DailyCheckInSchema,
      TodoSchema,
      MoodLogSchema,
      ReflectionSchema,
      AIConversationSchema,
      MessageSchema,
      UserProfileSchema,
      NotificationHistorySchema,
      AchievementSchema,
      WeeklyReviewSchema,
      EnglishPracticeSpeakingLogSchema,
      ActivityLogSchema,
    ], directory: dir.path);
  }
}
