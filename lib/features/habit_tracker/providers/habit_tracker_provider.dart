import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/notifications/notification_service.dart';
import 'package:riseup/features/habit_tracker/models/habit_tracker.dart';
import 'package:riseup/features/habit_tracker/repositories/habit_tracker_repository.dart';

final habitTrackerRepositoryProvider = Provider<HabitTrackerRepository>((ref) {
  return HabitTrackerRepository();
});

final habitTrackersProvider =
    AsyncNotifierProvider<HabitTrackersNotifier, List<HabitTracker>>(() {
      return HabitTrackersNotifier();
    });

class HabitTrackersNotifier extends AsyncNotifier<List<HabitTracker>> {
  @override
  Future<List<HabitTracker>> build() async {
    return ref.watch(habitTrackerRepositoryProvider).loadTrackers();
  }

  Future<void> createTracker(String name, int totalDays) async {
    final current = state.valueOrNull ?? await build();
    if (current.any((tracker) => tracker.isActive)) return;

    final tracker = HabitTracker(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      totalDays: totalDays,
      completedDays: <int>{},
      createdAt: DateTime.now(),
    );
    final updated = [tracker, ...current];
    await ref.read(habitTrackerRepositoryProvider).saveTrackers(updated);
    await NotificationService.syncHabitTrackerReminders(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> toggleDay(String trackerId, int day) async {
    final current = state.valueOrNull ?? await build();
    final updated = current.map((tracker) {
      if (tracker.id != trackerId) return tracker;
      if (day > tracker.maxUnlockedDay) return tracker;

      // Completed days are locked and cannot be unchecked
      if (tracker.completedDays.contains(day)) return tracker;

      final completedDays = Set<int>.from(tracker.completedDays)..add(day);
      return tracker.copyWith(completedDays: completedDays);
    }).toList();

    await ref.read(habitTrackerRepositoryProvider).saveTrackers(updated);
    await NotificationService.syncHabitTrackerReminders(updated);
    state = AsyncValue.data(updated);
  }

  Future<void> deleteTracker(String trackerId) async {
    final current = state.valueOrNull ?? await build();
    final updated = current
        .where((tracker) => tracker.id != trackerId)
        .toList();
    await ref.read(habitTrackerRepositoryProvider).saveTrackers(updated);
    await NotificationService.syncHabitTrackerReminders(updated);
    state = AsyncValue.data(updated);
  }
}
