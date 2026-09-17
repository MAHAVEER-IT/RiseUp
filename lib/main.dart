import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'core/database/database_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/notifications/notification_service.dart';
import 'features/companion/models/companion_mode.dart';
import 'features/goals/models/todo.dart';
import 'features/habit_tracker/repositories/habit_tracker_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isar = await DatabaseProvider.init();

  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isar)],
      child: const RiseUpApp(),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _startNotificationServices(isar);
  });
}

Future<void> _startNotificationServices(Isar isar) async {
  try {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    await NotificationService.enableCompanionNotifications(
      mode: CompanionMode.balanced,
    );
    final activeTodos = await isar.todos
        .filter()
        .isCompletedEqualTo(false)
        .findAll();
    await NotificationService.restoreTodoNotifications(activeTodos);
    final habitTrackers = await HabitTrackerRepository().loadTrackers();
    await NotificationService.syncHabitTrackerReminders(habitTrackers);
    NotificationService.handlePendingNotificationTap();
  } catch (error, stackTrace) {
    debugPrint('Notification startup failed: $error');
    debugPrintStack(stackTrace: stackTrace);
  }
}

class RiseUpApp extends ConsumerWidget {
  const RiseUpApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'RiseUp AI',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
