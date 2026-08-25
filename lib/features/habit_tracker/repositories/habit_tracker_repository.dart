import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:riseup/features/habit_tracker/models/habit_tracker.dart';

class HabitTrackerRepository {
  static const String _fileName = 'habit_trackers.json';

  Future<File> _file() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<List<HabitTracker>> loadTrackers() async {
    final file = await _file();
    if (!await file.exists()) return [];

    final raw = await file.readAsString();
    if (raw.trim().isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => HabitTracker.fromJson(item as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> saveTrackers(List<HabitTracker> trackers) async {
    final file = await _file();
    final payload = trackers.map((tracker) => tracker.toJson()).toList();
    await file.writeAsString(jsonEncode(payload), flush: true);
  }
}
