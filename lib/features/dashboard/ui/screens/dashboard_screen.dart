import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riseup/features/goals/models/todo.dart';
import 'package:riseup/features/goals/providers/todo_provider.dart';
import 'package:riseup/features/wellness/providers/wellness_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with TickerProviderStateMixin {
  static const String _userName = 'MAHAVEER';

  late final AnimationController _motionController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;

  @override
  void initState() {
    super.initState();
    _motionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 720),
    )..forward();
    _introAnimation = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _introController.dispose();
    _motionController.dispose();
    super.dispose();
  }

  String _getEnergyText(int energyScore) {
    switch (energyScore) {
      case 1:
        return 'Very Low';
      case 2:
        return 'Low';
      case 3:
        return 'Normal';
      case 4:
        return 'High';
      case 5:
        return 'Excellent';
      default:
        return 'Normal';
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    if (hour < 21) return 'Good evening';
    return 'Good night';
  }

  @override
  Widget build(BuildContext context) {
    final checkInState = ref.watch(todayCheckInProvider);
    final todosState = ref.watch(activeTodosProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: const Text('RiseUp'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.72),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
              ),
              child: IconButton(
                tooltip: 'Quick update',
                icon: const Icon(Icons.bolt_rounded),
                color: const Color(0xFF1F3D36),
                onPressed: () => context.push('/quick-update'),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _motionController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _HomeBackdropPainter(_motionController.value),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: _motionController,
                        builder: (context, _) {
                          return _HeroPanel(
                            greeting: _getGreeting(),
                            userName: _userName,
                            progress: _motionController.value,
                            onStartGoal: () => context.push('/todo-creation'),
                            onChat: () => context.push('/ai-chat'),
                            onHabitTracker: () =>
                                context.push('/habit-tracker'),
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      checkInState.when(
                        data: (checkIn) {
                          if (!checkIn.morningCompleted) {
                            return _CheckInPromptCard(
                              onPressed: () => context.push('/check-in'),
                            );
                          }

                          return _EnergyCard(
                            energyText: _getEnergyText(
                              checkIn.energyScore,
                            ),
                            energyScore: checkIn.energyScore,
                          );
                        },
                        loading: () => const _LoadingCard(),
                        error: (e, _) => const _MessageCard(
                          icon: Icons.warning_amber_rounded,
                          title: 'Could not load check-in',
                          message: 'Try again in a moment.',
                        ),
                      ),
                      const SizedBox(height: 18),
                      _ResetCard(onPressed: () => context.push('/ai-chat')),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'To-Do List',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF20332F),
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () => context.push('/todo-creation'),
                            icon: const Icon(Icons.add_rounded, size: 18),
                            label: const Text('Add'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      todosState.when(
                        data: (todos) {
                          if (todos.isEmpty) {
                            return _EmptyGoalsCard(
                              onPressed: () =>
                                  context.push('/todo-creation'),
                            );
                          }

                          return Column(
                            children: [
                              for (var index = 0;
                                  index < todos.length;
                                  index++)
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0, end: 1),
                                  duration: Duration(
                                    milliseconds: 420 + (index * 90),
                                  ),
                                  curve: Curves.easeOutCubic,
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0, 20 * (1 - value)),
                                      child: Opacity(
                                        opacity: value,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: _TodoTile(
                                    todo: todos[index],
                                    onTap: () {
                                      context.push(
                                        '/todo-detail?todoId=${todos[index].id}',
                                      );
                                    },
                                  ),
                                ),
                            ],
                          );
                        },
                        loading: () => const _LoadingCard(),
                        error: (e, _) => const _MessageCard(
                          icon: Icons.error_outline_rounded,
                          title: 'To-Dos are taking a pause',
                          message: 'Could not load your To-Dos.',
                        ),
                      ),
                    ],
                  ),
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
  const _HeroPanel({
    required this.greeting,
    required this.userName,
    required this.progress,
    required this.onStartGoal,
    required this.onChat,
    required this.onHabitTracker,
  });

  final String greeting;
  final String userName;
  final double progress;
  final VoidCallback onStartGoal;
  final VoidCallback onChat;
  final VoidCallback onHabitTracker;

  @override
  Widget build(BuildContext context) {
    final shimmer = Alignment.lerp(
      const Alignment(-1.1, -1),
      const Alignment(1.1, 1),
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
            Color(0xFF25463C),
            Color(0xFF6F9E88),
            Color(0xFFF0B08D),
          ],
          stops: [0, 0.58 + (progress * 0.08), 1],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF25463C).withValues(alpha: 0.26),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24 + (progress * 18),
            top: -22,
            child: Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.14),
              ),
            ),
          ),
          Positioned(
            right: 38,
            bottom: -34 + (math.sin(progress * math.pi) * 14),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 88,
              color: Colors.white.withValues(alpha: 0.14),
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
                  'Today feels buildable',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
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
                child: Text(
                  '$greeting,\n$userName.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    height: 1.04,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Pick one steady step. Let the rest of the day orbit around it.',
                style: TextStyle(
                  color: Color(0xFFEAF4EF),
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF25463C),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                    ),
                    onPressed: onStartGoal,
                    icon: const Icon(Icons.checklist_rounded, size: 18),
                    label: const Text('New To-Do'),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.64),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                    ),
                    onPressed: onChat,
                    icon: const Icon(Icons.forum_rounded, size: 18),
                    label: const Text('Talk'),
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.64),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 13,
                      ),
                    ),
                    onPressed: onHabitTracker,
                    icon: const Icon(Icons.grid_view_rounded, size: 18),
                    label: const Text('Habits'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CheckInPromptCard extends StatelessWidget {
  const _CheckInPromptCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Row(
        children: [
          const _IconBadge(
            icon: Icons.wb_sunny_rounded,
            color: Color(0xFFE99572),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick check-in',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 5),
                Text(
                  'Mood and energy first, then the next step becomes clearer.',
                  style: TextStyle(color: Color(0xFF65706B), height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton.filled(
            tooltip: 'Start check-in',
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
    );
  }
}

class _EnergyCard extends StatelessWidget {
  const _EnergyCard({required this.energyText, required this.energyScore});

  final String energyText;
  final int energyScore;

  @override
  Widget build(BuildContext context) {
    final normalized = energyScore.clamp(1, 5) / 5;

    return _GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _IconBadge(
                icon: Icons.battery_charging_full_rounded,
                color: Color(0xFF4D8C76),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Your Energy: $energyText',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF243C36),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: normalized,
              minHeight: 10,
              backgroundColor: const Color(0xFFE4E9E2),
              color: energyScore < 3
                  ? const Color(0xFFE99572)
                  : const Color(0xFF4D8C76),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            energyScore < 3
                ? 'Keep today light. Try one 5-minute easy win, then rest without guilt.'
                : 'You have solid energy. A 30-minute focus session would be a strong next step.',
            style: const TextStyle(
              fontSize: 15,
              height: 1.42,
              color: Color(0xFF4C5753),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResetCard extends StatelessWidget {
  const _ResetCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF3DF), Color(0xFFE9F4EC)],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
      ),
      child: Row(
        children: [
          const _IconBadge(
            icon: Icons.auto_awesome_rounded,
            color: Color(0xFFB86F56),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need a reset?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 5),
                Text(
                  'Talk through the stuck point and turn it into one doable move.',
                  style: TextStyle(color: Color(0xFF65706B), height: 1.35),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Talk to RiseUp',
            onPressed: onPressed,
            icon: const Icon(Icons.chat_bubble_rounded),
            color: const Color(0xFF25463C),
          ),
        ],
      ),
    );
  }
}

class _TodoTile extends ConsumerWidget {
  const _TodoTile({required this.todo, required this.onTap});

  final Todo todo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedSubCount = todo.subTodos.where((s) => s.isCompleted).length;
    final totalSubCount = todo.subTodos.length;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Checkbox(
                  value: todo.isCompleted,
                  activeColor: const Color(0xFF4D8C76),
                  onChanged: (val) {
                    ref.read(activeTodosProvider.notifier).toggleTodo(todo.id);
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: todo.isCompleted ? const Color(0xFF8A9590) : const Color(0xFF243C36),
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (todo.dueTime != null) ...[
                            const Icon(Icons.access_time_rounded, size: 13, color: Color(0xFF4D8C76)),
                            const SizedBox(width: 4),
                            Text(
                              TimeOfDay.fromDateTime(todo.dueTime!).format(context),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4D8C76),
                              ),
                            ),
                            if (totalSubCount > 0) const Text('  •  ', style: TextStyle(color: Color(0xFF65706B))),
                          ],
                          if (totalSubCount > 0)
                            Text(
                              '$completedSubCount of $totalSubCount subtasks',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF65706B),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.chevron_right_rounded, size: 22, color: Color(0xFF65706B)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyGoalsCard extends StatelessWidget {
  const _EmptyGoalsCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        children: [
          const _IconBadge(icon: Icons.checklist_rounded, color: Color(0xFF4D8C76)),
          const SizedBox(height: 12),
          const Text(
            'Your day is open.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create a to-do list for today to stay aligned and clear.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF65706B), height: 1.4),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.add_task_rounded, size: 18),
            label: const Text('Create To-Do'),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.86)),
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
  const _IconBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return const _GlassCard(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.icon,
    required this.title,
    required this.message,
  });

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Row(
        children: [
          _IconBadge(icon: icon, color: const Color(0xFFE07165)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
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
    );
  }
}

class _HomeBackdropPainter extends CustomPainter {
  const _HomeBackdropPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF8F3E7), Color(0xFFE7F2EA), Color(0xFFFFECE0)],
      ).createShader(rect);

    canvas.drawRect(rect, backgroundPaint);

    void drawGlow(Color color, Offset center, double radius) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: 0.28), color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    drawGlow(
      const Color(0xFF77A98E),
      Offset(size.width * (0.14 + progress * 0.06), size.height * 0.18),
      size.width * 0.58,
    );
    drawGlow(
      const Color(0xFFE99572),
      Offset(size.width * (0.92 - progress * 0.08), size.height * 0.12),
      size.width * 0.46,
    );
    drawGlow(
      const Color(0xFF6F8EDB),
      Offset(size.width * 0.82, size.height * (0.82 - progress * 0.06)),
      size.width * 0.5,
    );
  }

  @override
  bool shouldRepaint(covariant _HomeBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
