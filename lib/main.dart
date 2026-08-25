import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/notifications/notification_service.dart';
import 'features/companion/models/companion_mode.dart';

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
    _startCompanionServices();
  });
}

Future<void> _startCompanionServices() async {
  try {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    await NotificationService.enableCompanionNotifications(
      mode: CompanionMode.balanced,
    );
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
