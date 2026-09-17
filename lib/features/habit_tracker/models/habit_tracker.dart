class HabitTracker {
  HabitTracker({
    required this.id,
    required this.name,
    required this.totalDays,
    required this.completedDays,
    required this.createdAt,
  });

  final String id;
  final String name;
  final int totalDays;
  final Set<int> completedDays;
  final DateTime createdAt;

  int get completedCount => completedDays.length;

  double get progress => totalDays == 0 ? 0 : completedCount / totalDays;

  bool get isComplete => completedCount >= totalDays;

  /// A tracker is active through its final calendar day. It expires even when
  /// the user has not checked every day off, so it cannot keep prompting them
  /// after the commitment they chose has ended.
  bool get hasEnded {
    final start = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final finalDay = start.add(Duration(days: totalDays - 1));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return today.isAfter(finalDay);
  }

  bool get isActive => !isComplete && !hasEnded;

  int get maxUnlockedDay {
    final daysSinceStart = DateTime.now()
        .difference(DateTime(createdAt.year, createdAt.month, createdAt.day))
        .inDays;
    return (daysSinceStart + 1).clamp(1, totalDays);
  }

  HabitTracker copyWith({
    String? id,
    String? name,
    int? totalDays,
    Set<int>? completedDays,
    DateTime? createdAt,
  }) {
    return HabitTracker(
      id: id ?? this.id,
      name: name ?? this.name,
      totalDays: totalDays ?? this.totalDays,
      completedDays: completedDays ?? Set<int>.from(this.completedDays),
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'totalDays': totalDays,
      'completedDays': completedDays.toList()..sort(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HabitTracker.fromJson(Map<String, dynamic> json) {
    return HabitTracker(
      id: json['id'] as String,
      name: json['name'] as String,
      totalDays: json['totalDays'] as int,
      completedDays: ((json['completedDays'] as List<dynamic>?) ?? [])
          .map((value) => value as int)
          .toSet(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
