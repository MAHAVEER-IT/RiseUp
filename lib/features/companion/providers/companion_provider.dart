import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/core/network/gemini_provider.dart';
import 'package:riseup/core/companion/companion_monitoring_service_v2.dart';
import 'package:riseup/core/companion/companion_ai_response_service_v2.dart';
import 'package:riseup/core/companion/companion_analytics_service.dart';
import 'package:riseup/features/companion/repositories/activity_repository.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'package:riseup/features/companion/models/companion_settings.dart';

// Activity Repository Provider
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return ActivityRepository(isar);
});

// Companion Settings Provider
final companionSettingsProvider = Provider<CompanionSettings>((ref) {
  return CompanionSettings.createDefault();
});

// Companion Monitoring Service Provider
final companionMonitoringServiceProvider = Provider<CompanionMonitoringService>(
  (ref) {
    final activityRepository = ref.watch(activityRepositoryProvider);
    final settings = ref.watch(companionSettingsProvider);
    return CompanionMonitoringService(
      settings: settings,
      activityRepository: activityRepository,
    );
  },
);

// Companion AI Response Service Provider
final companionAIResponseServiceProvider =
    Provider<CompanionAIResponseServiceV2>((ref) {
      final geminiService = ref.watch(geminiServiceProvider);
      final activityRepository = ref.watch(activityRepositoryProvider);
      return CompanionAIResponseServiceV2(
        geminiService: geminiService,
        activityRepository: activityRepository,
      );
    });

// Companion Analytics Service Provider
final companionAnalyticsServiceProvider = Provider<CompanionAnalyticsService>((
  ref,
) {
  final activityRepository = ref.watch(activityRepositoryProvider);
  return CompanionAnalyticsService(activityRepository);
});

// User Activity Logs Provider (AsyncNotifier)
final userActivityProvider =
    AsyncNotifierProvider<UserActivityNotifier, List<ActivityLog>>(
      () => UserActivityNotifier(),
    );

class UserActivityNotifier extends AsyncNotifier<List<ActivityLog>> {
  @override
  Future<List<ActivityLog>> build() async {
    final repository = ref.watch(activityRepositoryProvider);
    return repository.getActivitiesForToday();
  }

  Future<void> addActivity({
    required String activityType,
    String? additionalNote,
  }) async {
    final repository = ref.watch(activityRepositoryProvider);
    final activity = ActivityLog()
      ..timestamp = DateTime.now()
      ..activity = _parseActivityType(activityType)
      ..additionalNote = additionalNote;

    await repository.saveActivity(activity);

    // Refresh the list
    state = await AsyncValue.guard(() => repository.getActivitiesForToday());
  }

  Future<void> deleteActivity(int id) async {
    final repository = ref.watch(activityRepositoryProvider);
    await repository.deleteActivity(id);

    // Refresh the list
    state = await AsyncValue.guard(() => repository.getActivitiesForToday());
  }

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
      default:
        return ActivityType.takingBreak;
    }
  }
}

// Activity Statistics Provider
final activityStatsProvider = FutureProvider<Map<String, int>>((ref) async {
  final repository = ref.watch(activityRepositoryProvider);
  final activities = await repository.getActivitiesForToday();

  final stats = <String, int>{};
  for (final activity in activities) {
    final name = CompanionMonitoringService.getActivityNameStatic(
      activity.activity,
    );
    stats[name] = (stats[name] ?? 0) + 1;
  }

  return stats;
});
