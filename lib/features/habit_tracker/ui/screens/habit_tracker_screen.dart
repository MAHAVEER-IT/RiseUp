import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/features/habit_tracker/models/habit_tracker.dart';
import 'package:riseup/features/habit_tracker/providers/habit_tracker_provider.dart';

class HabitTrackerScreen extends ConsumerStatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  ConsumerState<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends ConsumerState<HabitTrackerScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _habitController = TextEditingController();
  final _daysController = TextEditingController(text: '30');

  late final AnimationController _motionController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;

  @override
  void initState() {
    super.initState();
    _motionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 680),
    )..forward();
    _introAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _habitController.dispose();
    _daysController.dispose();
    _introController.dispose();
    _motionController.dispose();
    super.dispose();
  }

  Future<void> _createTracker() async {
    if (!_formKey.currentState!.validate()) return;
    final name = _habitController.text.trim();
    final totalDays = int.parse(_daysController.text.trim());

    await ref
        .read(habitTrackersProvider.notifier)
        .createTracker(name, totalDays);

    if (!mounted) return;
    _habitController.clear();
    FocusScope.of(context).unfocus();
  }

  Future<void> _confirmDelete(HabitTracker tracker) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete tracker?'),
          content: Text('Remove "${tracker.name}" and its crossed days?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return;
    await ref.read(habitTrackersProvider.notifier).deleteTracker(tracker.id);
  }

  Future<void> _toggleDayWithCelebration(HabitTracker tracker, int day) async {
    final completesTracker =
        !tracker.completedDays.contains(day) &&
        tracker.completedCount + 1 >= tracker.totalDays;

    await ref.read(habitTrackersProvider.notifier).toggleDay(tracker.id, day);

    if (!mounted || !completesTracker) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return _CompletionCelebrationDialog(tracker: tracker);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final trackersState = ref.watch(habitTrackersProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF7F2E8),
      appBar: AppBar(
        title: const Text('Habit Tracker'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _motionController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _HabitBackdropPainter(_motionController.value),
                );
              },
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _introAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(_introAnimation),
                child: trackersState.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                  error: (_, __) => const _MessagePanel(
                    icon: Icons.warning_amber_rounded,
                    title: 'Could not load habits',
                    message: 'Try again in a moment.',
                  ),
                  data: (trackers) {
                    final hasActiveTracker = trackers.any(
                      (tracker) => !tracker.isComplete,
                    );

                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedBuilder(
                            animation: _motionController,
                            builder: (context, _) {
                              return _HeroPanel(progress: _motionController.value);
                            },
                          ),
                          const SizedBox(height: 18),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 320),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SizeTransition(
                                  sizeFactor: animation,
                                  axisAlignment: -1,
                                  child: child,
                                ),
                              );
                            },
                            child: hasActiveTracker
                                ? const SizedBox.shrink(
                                    key: ValueKey('hidden-create-tracker'),
                                  )
                                : _CreateTrackerPanel(
                                    key: const ValueKey(
                                      'create-tracker-panel',
                                    ),
                                    formKey: _formKey,
                                    habitController: _habitController,
                                    daysController: _daysController,
                                    onSubmit: _createTracker,
                                  ),
                          ),
                          SizedBox(height: hasActiveTracker ? 0 : 24),
                          if (trackers.isEmpty)
                            const _EmptyTrackerPanel()
                          else ...[
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Quit Trackers',
                                    style: TextStyle(
                                      color: Color(0xFF20332F),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${trackers.length}',
                                  style: const TextStyle(
                                    color: Color(0xFF6A746F),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            for (var index = 0;
                                index < trackers.length;
                                index++)
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: Duration(
                                  milliseconds: 380 + (index * 80),
                                ),
                                curve: Curves.easeOutCubic,
                                builder: (context, value, child) {
                                  return Transform.translate(
                                    offset: Offset(0, 18 * (1 - value)),
                                    child: Opacity(
                                      opacity: value,
                                      child: child,
                                    ),
                                  );
                                },
                                child: _HabitTrackerCard(
                                  tracker: trackers[index],
                                  onToggleDay: (day) {
                                    _toggleDayWithCelebration(
                                      trackers[index],
                                      day,
                                    );
                                  },
                                  onDelete: () =>
                                      _confirmDelete(trackers[index]),
                                ),
                              ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final shimmer = Alignment.lerp(
      const Alignment(-1, -0.8),
      const Alignment(1, 0.9),
      progress,
    )!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [
            Color(0xFF233F39),
            Color(0xFF4D8C76),
            Color(0xFFE6A16F),
          ],
          stops: [0, 0.56 + (progress * 0.08), 1],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF233F39).withValues(alpha: 0.24),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20 + (progress * 18),
            top: -26,
            child: Container(
              width: 122,
              height: 122,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.13),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -34 + (math.sin(progress * math.pi) * 12),
            child: Icon(
              Icons.grid_view_rounded,
              color: Colors.white.withValues(alpha: 0.14),
              size: 90,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.24),
                  ),
                ),
                child: const Text(
                  'Break the chain',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: shimmer,
                    end: Alignment.bottomRight,
                    colors: const [
                      Colors.white,
                      Color(0xFFFFE4C9),
                      Colors.white,
                    ],
                  ).createShader(bounds);
                },
                child: const Text(
                  'One honest day.\nOne crossed box.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Name the habit, choose the promise, then mark each day as you earn it.',
                style: TextStyle(
                  color: Color(0xFFEAF4EF),
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CreateTrackerPanel extends StatelessWidget {
  const _CreateTrackerPanel({
    super.key,
    required this.formKey,
    required this.habitController,
    required this.daysController,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController habitController;
  final TextEditingController daysController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                _IconBadge(icon: Icons.edit_note_rounded),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Create a quit tracker',
                    style: TextStyle(
                      color: Color(0xFF223A34),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: habitController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Bad habit name',
                hintText: 'Example: scrolling at night',
                prefixIcon: Icon(Icons.block_rounded),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Add the habit you want to quit.';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: daysController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of days',
                hintText: '30',
                prefixIcon: Icon(Icons.calendar_month_rounded),
              ),
              validator: (value) {
                final days = int.tryParse((value ?? '').trim());
                if (days == null || days < 1) {
                  return 'Choose at least 1 day.';
                }
                if (days > 365) {
                  return 'Keep it under 365 days for now.';
                }
                return null;
              },
              onFieldSubmitted: (_) => onSubmit(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.add_task_rounded, size: 18),
                label: const Text('Create Tracker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HabitTrackerCard extends StatelessWidget {
  const _HabitTrackerCard({
    required this.tracker,
    required this.onToggleDay,
    required this.onDelete,
  });

  final HabitTracker tracker;
  final ValueChanged<int> onToggleDay;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final progressText = '${tracker.completedCount}/${tracker.totalDays} days';
    final percentage = (tracker.progress * 100).round();
    final today = tracker.maxUnlockedDay;
    final primaryGreen = const Color(0xFF234B3D);
    final emeraldGreen = tracker.isComplete
        ? const Color(0xFF2E7D5F)
        : const Color(0xFF3F8A70);
    final mintGreen = const Color(0xFF5DB38A);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: _TrackerCardSurface(
        accent: emeraldGreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: emeraldGreen.withValues(alpha: 0.13),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: mintGreen.withValues(alpha: 0.3)),
                  ),
                  child: Icon(
                    tracker.isComplete
                        ? Icons.verified_rounded
                        : Icons.local_fire_department_rounded,
                    color: emeraldGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tracker.name,
                        style: const TextStyle(
                          color: Color(0xFF223A34),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        progressText,
                        style: const TextStyle(
                          color: Color(0xFF69756F),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE0E5DC),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF24463B).withValues(alpha: 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: PopupMenuButton<String>(
                    tooltip: 'Tracker options',
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Color(0xFF234B3D),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    onSelected: (value) {
                      if (value == 'delete') onDelete();
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFFD32F2F),
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Delete tracker',
                              style: TextStyle(
                                color: Color(0xFFD32F2F),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'YOUR PROGRESS',
                  style: TextStyle(
                    color: Color(0xFF6A746F),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.9,
                  ),
                ),
                const Spacer(),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    color: emeraldGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: tracker.progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFE2EBE5),
                color: emeraldGreen,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F4).withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE5E8E1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: mintGreen.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          tracker.isComplete
                              ? Icons.emoji_events_rounded
                              : Icons.calendar_month_rounded,
                          size: 14,
                          color: primaryGreen,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'YOUR QUIT JOURNEY',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF69756F),
                        ),
                      ),
                      const Spacer(),
                      if (!tracker.isComplete)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: emeraldGreen.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Day $today',
                            style: TextStyle(
                              color: primaryGreen,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: tracker.totalDays,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                    ),
                    itemBuilder: (context, index) {
                      final day = index + 1;
                      return _DayBox(
                        day: day,
                        isCompleted: tracker.completedDays.contains(day),
                        isUnlocked: day <= tracker.maxUnlockedDay,
                        onTap: () => onToggleDay(day),
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    alignment: WrapAlignment.end,
                    runSpacing: 6,
                    spacing: 12,
                    children: [
                      _LegendItem(
                        color: const Color(0xFF4D8C76),
                        label: 'Done (Locked)',
                      ),
                      _LegendItem(
                        color: Colors.white,
                        label: 'Tap to mark',
                        border: Border.all(color: const Color(0xFFE4E1D8)),
                      ),
                      _LegendItem(
                        color: const Color(0xFFE4E2DC).withValues(alpha: 0.72),
                        label: 'Locked',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackerCardSurface extends StatelessWidget {
  const _TrackerCardSurface({required this.accent, required this.child});

  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.96),
            const Color(0xFFF5F8F2).withValues(alpha: 0.94),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF24463B).withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -6,
            right: -6,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.55,
                child: Image.asset(
                  'images/flower_corner.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: -72,
            right: -58,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF64B692).withValues(alpha: 0.18),
                    const Color(0xFF3F8A70).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF234B3D),
                    Color(0xFF3F8A70),
                    Color(0xFF64B692),
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(20), child: child),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    this.border,
  });

  final Color color;
  final String label;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            border: border,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF69756F),
          ),
        ),
      ],
    );
  }
}

class _DayBox extends StatefulWidget {
  const _DayBox({
    Key? key,
    required this.day,
    required this.isCompleted,
    required this.isUnlocked,
    required this.onTap,
  }) : super(key: key);

  final int day;
  final bool isCompleted;
  final bool isUnlocked;
  final VoidCallback onTap;

  @override
  State<_DayBox> createState() => _DayBoxState();
}

class _DayBoxState extends State<_DayBox> with SingleTickerProviderStateMixin {
  late final AnimationController _celebrationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.32).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.32, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 65,
      ),
    ]).animate(_celebrationController);
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _DayBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCompleted && !oldWidget.isCompleted) {
      _celebrationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final background = widget.isCompleted
        ? const Color(0xFF4D8C76)
        : widget.isUnlocked
        ? Colors.white.withValues(alpha: 0.84)
        : const Color(0xFFE4E2DC).withValues(alpha: 0.72);
    final foreground = widget.isCompleted
        ? Colors.white
        : widget.isUnlocked
        ? const Color(0xFF344942)
        : const Color(0xFF9CA49F);

    return AnimatedBuilder(
      animation: _celebrationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _celebrationController.isAnimating ? _scaleAnimation.value : 1.0,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              child!,
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _BoxConfettiPainter(_celebrationController.value),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: widget.isCompleted
                ? const Color(0xFF3B705D)
                : Colors.white.withValues(alpha: 0.86),
            width: widget.isCompleted ? 1.5 : 1.0,
          ),
          boxShadow: widget.isCompleted
              ? [
                  BoxShadow(
                    color: const Color(0xFF4D8C76).withValues(alpha: 0.22),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isCompleted
                ? () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Day ${widget.day} is checked and locked! 🔒 Keep it up!',
                        ),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                : widget.isUnlocked
                    ? widget.onTap
                    : () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Day ${widget.day} unlocks on Day ${widget.day} ⏳',
                            ),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
            child: SizedBox.expand(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      '${widget.day}',
                      style: TextStyle(
                        color: foreground,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  if (widget.isCompleted)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          color: Color(0xFF4D8C76),
                          size: 13,
                        ),
                      ),
                    ),
                  if (!widget.isUnlocked)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(
                        Icons.lock_rounded,
                        color: foreground.withValues(alpha: 0.55),
                        size: 14,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BoxConfettiPainter extends CustomPainter {
  _BoxConfettiPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.0 || progress >= 1.0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final random = math.Random(77);

    final colors = [
      const Color(0xFF4D8C76), // emerald
      const Color(0xFFFFB300), // amber
      const Color(0xFFFF6F00), // coral
      const Color(0xFF29B6F6), // light blue
      const Color(0xFFEC407A), // pink
      const Color(0xFF26A69A), // teal
      const Color(0xFFAB47BC), // purple
      const Color(0xFF66BB6A), // light green
    ];

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    final highlightPaint = Paint()..style = PaintingStyle.fill;

    const particleCount = 14;
    final fade = (1.0 - progress).clamp(0.0, 1.0);

    for (int i = 0; i < particleCount; i++) {
      final baseAngle = (i * 2 * math.pi / particleCount);
      final angle = baseAngle + (random.nextDouble() * 0.35 - 0.175);

      // Much larger outward blast radius (50 to 95px from center)
      final maxDistance = 50.0 + (random.nextDouble() * 42.0);
      final distance = maxDistance * math.sin(progress * math.pi / 2);

      final x = center.dx + math.cos(angle) * distance;
      final y = center.dy + math.sin(angle) * distance;

      final color = colors[i % colors.length];
      fillPaint.color = color.withValues(alpha: fade * 0.92);
      strokePaint.color = color.withValues(alpha: fade * 0.85);
      highlightPaint.color = Colors.white.withValues(alpha: fade * 0.82);

      // Much larger bubble size (radius 7.5 to 15.0px, diameter 15 to 30px)
      final baseRadius = 7.5 + (random.nextDouble() * 7.5);
      final bubbleRadius =
          (baseRadius * (1.1 - (progress * 0.4))).clamp(3.5, 16.0);

      if (i % 4 == 0) {
        // Soap ring bubble
        canvas.drawCircle(Offset(x, y), bubbleRadius, strokePaint);
        canvas.drawCircle(Offset(x, y), bubbleRadius * 0.28, highlightPaint);
      } else if (i % 4 == 2) {
        // Sparkle diamond star
        final sparkleSize = bubbleRadius * 1.15;
        final path = Path()
          ..moveTo(x, y - sparkleSize)
          ..quadraticBezierTo(x, y, x + sparkleSize, y)
          ..quadraticBezierTo(x, y, x, y + sparkleSize)
          ..quadraticBezierTo(x, y, x - sparkleSize, y)
          ..quadraticBezierTo(x, y, x, y - sparkleSize)
          ..close();
        canvas.drawPath(path, fillPaint);
      } else {
        // Full glossy celebration bubble with specular gleam
        canvas.drawCircle(Offset(x, y), bubbleRadius, fillPaint);
        canvas.drawCircle(
          Offset(x - (bubbleRadius * 0.32), y - (bubbleRadius * 0.32)),
          (bubbleRadius * 0.32).clamp(1.5, 5.0),
          highlightPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BoxConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _EmptyTrackerPanel extends StatelessWidget {
  const _EmptyTrackerPanel();

  @override
  Widget build(BuildContext context) {
    return const _GlassPanel(
      child: Column(
        children: [
          _IconBadge(icon: Icons.grid_view_rounded),
          SizedBox(height: 12),
          Text(
            'No tracker yet.',
            style: TextStyle(
              color: Color(0xFF223A34),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Create one promise above. The first box unlocks today.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF65706B), height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _CompletionCelebrationDialog extends StatefulWidget {
  const _CompletionCelebrationDialog({required this.tracker});

  final HabitTracker tracker;

  @override
  State<_CompletionCelebrationDialog> createState() =>
      _CompletionCelebrationDialogState();
}

class _CompletionCelebrationDialogState
    extends State<_CompletionCelebrationDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _popAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
    _popAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.42, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _CelebrationSparkPainter(_controller.value),
                ),
              ),
              Transform.scale(
                scale: _popAnimation.value.clamp(0.72, 1.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFEAF4EF),
                        Color(0xFFFFE8D7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF233F39,
                        ).withValues(alpha: 0.24),
                        blurRadius: 34,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 82,
                        height: 82,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4D8C76),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF4D8C76,
                              ).withValues(alpha: 0.28),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 46,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'You completed it.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF20332F),
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          height: 1.08,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '"${widget.tracker.name}" is no longer just a promise. You showed up for ${widget.tracker.totalDays} days.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF52605A),
                          fontSize: 15,
                          height: 1.45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4D8C76).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(
                              0xFF4D8C76,
                            ).withValues(alpha: 0.18),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xFFE99572),
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Take a second. Let your brain feel the win.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF20332F),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.celebration_rounded, size: 18),
                          label: const Text('Celebrate This'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CelebrationSparkPainter extends CustomPainter {
  const _CelebrationSparkPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final colors = [
      const Color(0xFFE99572),
      const Color(0xFF4D8C76),
      const Color(0xFF6F8EDB),
      const Color(0xFFF1C15D),
    ];

    for (var i = 0; i < 22; i++) {
      final angle = (math.pi * 2 / 22) * i;
      final wave = math.sin((progress * math.pi * 2) + i);
      final distance = 42 + (progress * 118) + (wave * 10);
      final point = center + Offset(math.cos(angle), math.sin(angle)) * distance;
      final fade = (1 - progress).clamp(0.0, 1.0);
      final paint = Paint()
        ..color = colors[i % colors.length].withValues(alpha: fade * 0.85)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(point.dx, point.dy);
      canvas.rotate(angle + progress);
      final radius = 3.5 + ((i % 3) * 1.4);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: radius * 2, height: 7),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _CelebrationSparkPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _MessagePanel extends StatelessWidget {
  const _MessagePanel({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: _GlassPanel(
          child: Row(
            children: [
              _IconBadge(icon: icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message,
                      style: const TextStyle(color: Color(0xFF65706B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.88)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF315044).withValues(alpha: 0.08),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFF4D8C76).withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: const Color(0xFF4D8C76)),
    );
  }
}

class _HabitBackdropPainter extends CustomPainter {
  const _HabitBackdropPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF8F3E7), Color(0xFFE9F4EC), Color(0xFFFFEEE0)],
      ).createShader(rect);

    canvas.drawRect(rect, backgroundPaint);

    void drawGlow(Color color, Offset center, double radius) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: 0.26), color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    drawGlow(
      const Color(0xFF77A98E),
      Offset(size.width * (0.16 + progress * 0.05), size.height * 0.17),
      size.width * 0.58,
    );
    drawGlow(
      const Color(0xFFE99572),
      Offset(size.width * (0.92 - progress * 0.06), size.height * 0.14),
      size.width * 0.48,
    );
    drawGlow(
      const Color(0xFF6F8EDB),
      Offset(size.width * 0.82, size.height * (0.82 - progress * 0.06)),
      size.width * 0.5,
    );
  }

  @override
  bool shouldRepaint(covariant _HabitBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
