import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/features/wellness/ui/screens/check_in_screen.dart';
import 'package:riseup/features/dashboard/ui/screens/home_screen.dart';
import 'package:riseup/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:riseup/features/goals/ui/screens/todo_detail_screen.dart';
import 'package:riseup/features/goals/ui/screens/todo_creation_screen.dart';
import 'package:riseup/features/companion/ui/screens/quick_update_screen.dart';
import 'package:riseup/features/ai_chat/ui/screens/ai_chat_screen.dart';
import 'package:riseup/features/settings/ui/screens/settings_screen.dart';
import 'package:riseup/features/journal/ui/screens/journal_screen.dart';
import 'package:riseup/features/progress/ui/screens/progress_screen.dart';
import 'package:riseup/features/habit_tracker/ui/screens/habit_tracker_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

// Create a provider for the router so it can be dynamically maintained/updated with state
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/check-in',
        builder: (context, state) => const CheckInScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/todo-detail',
        builder: (context, state) {
          final todoId = state.uri.queryParameters['todoId'];
          return TodoDetailScreen(
            todoId: todoId != null ? int.parse(todoId) : 0,
          );
        },
      ),
      GoRoute(
        path: '/todo-creation',
        builder: (context, state) {
          final todoId = state.uri.queryParameters['todoId'];
          return TodoCreationScreen(
            todoId: todoId != null ? int.tryParse(todoId) : null,
          );
        },
      ),
      GoRoute(
        path: '/quick-update',
        builder: (context, state) => const QuickUpdateScreen(),
      ),
      GoRoute(
        path: '/ai-chat',
        builder: (context, state) => const AIChatScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/journal',
        builder: (context, state) => const JournalScreen(),
      ),
      GoRoute(
        path: '/progress',
        builder: (context, state) => const ProgressScreen(),
      ),
      GoRoute(
        path: '/habit-tracker',
        builder: (context, state) => const HabitTrackerScreen(),
      ),
    ],
  );
});
