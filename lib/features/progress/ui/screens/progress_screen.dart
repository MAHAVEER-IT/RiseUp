import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'package:riseup/features/goals/models/todo.dart';
import 'package:riseup/features/progress/models/weekly_review.dart';
import 'package:riseup/features/progress/providers/progress_summary_provider.dart';
import 'package:riseup/features/progress/providers/weekly_review_provider.dart';

class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen>
    with TickerProviderStateMixin {
  late final AnimationController _ambientController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;
  bool _generationRequestedByUser = false;

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(
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
    _ambientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final summaryState = ref.watch(progressSummaryProvider);
    final weeklyReviewState = ref.watch(weeklyReviewCheckerProvider);

    ref.listen<AsyncValue<void>>(weeklyReviewCheckerProvider, (previous, next) {
      if (_generationRequestedByUser && next.hasError && !next.isLoading) {
        _generationRequestedByUser = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not generate insight: ${next.error}'),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (_generationRequestedByUser &&
          previous?.isLoading == true &&
          !next.isLoading &&
          !next.hasError) {
        _generationRequestedByUser = false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Weekly insight generated successfully!'),
            backgroundColor: Color(0xFF25463C),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: const Row(
          children: [
            _ProgressMark(),
            SizedBox(width: 10),
            Text(
              'Progress',
              style: TextStyle(
                color: Color(0xFF20332F),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: AnimatedBuilder(
        animation: _ambientController,
        builder: (context, _) {
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _ProgressBackdropPainter(_ambientController.value),
                ),
              ),
              SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(progressSummaryProvider);
                  },
                  child: summaryState.when(
                    data: (summary) => FadeTransition(
                      opacity: _introAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.035),
                          end: Offset.zero,
                        ).animate(_introAnimation),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ProofHero(
                                summary: summary,
                                progress: _ambientController.value,
                              ),
                              const SizedBox(height: 20),
                              _ProofSignals(summary: summary),
                              const SizedBox(height: 22),
                              _WeeklyFocusPanel(summary: summary),
                              const SizedBox(height: 22),
                              _WeeklyInsightsPanel(
                                reviews: summary.weeklyReviews,
                                isGenerating: weeklyReviewState.isLoading,
                                hasCompletedTasks: summary.totalCompletedTodos > 0,
                                onGenerate: () async {
                                  if (summary.totalCompletedTodos == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Complete at least 1 task this week to unlock your AI insight.',
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    return;
                                  }
                                  _generationRequestedByUser = true;
                                  await ref
                                      .read(
                                        weeklyReviewCheckerProvider.notifier,
                                      )
                                      .forceGenerateReview();
                                  ref.invalidate(progressSummaryProvider);
                                },
                              ),
                              const SizedBox(height: 22),
                              _MilestonesPanel(summary: summary),
                            ],
                          ),
                        ),
                      ),
                    ),
                    loading: () => const _ProgressLoading(),
                    error: (error, _) =>
                        _ProgressError(message: error.toString()),
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

class _ProofHero extends StatelessWidget {
  const _ProofHero({required this.summary, required this.progress});

  final ProgressSummary summary;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final score = (summary.proofScore / 100).clamp(0.0, 1.0);
    final shimmer = Alignment.lerp(
      const Alignment(-1, -1),
      const Alignment(1, 1),
      progress,
    )!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF243C36), Color(0xFF5F927D), Color(0xFFF0B08D)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF243C36).withValues(alpha: 0.24),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -28 + (progress * 18),
            top: -26,
            child: Icon(
              Icons.auto_graph_rounded,
              size: 138,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _ProgressMark(inverted: true),
                  const Spacer(),
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
                      'Last 7 days',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: shimmer,
                    end: Alignment.bottomRight,
                    colors: const [
                      Colors.white,
                      Color(0xFFFFE6C7),
                      Colors.white,
                    ],
                  ).createShader(bounds);
                },
                child: Text(
                  summary.headline,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                    height: 1.08,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                summary.companionMessage,
                style: const TextStyle(
                  color: Color(0xFFEAF4EF),
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 22),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: score),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 12,
                      value: value,
                      backgroundColor: Colors.white.withValues(alpha: 0.16),
                      color: const Color(0xFFFFD09E),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Proof score ${summary.proofScore}/100',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProofSignals extends StatelessWidget {
  const _ProofSignals({required this.summary});

  final ProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    final signals = [
      _SignalData(
        icon: Icons.checklist_rounded,
        label: 'Active To-Dos',
        value: '${summary.activeTodos.length}',
        detail: 'open tasks',
        color: const Color(0xFF5A7FC8),
      ),
      _SignalData(
        icon: Icons.check_circle_rounded,
        label: 'Completed',
        value: '${summary.totalCompletedTodos}',
        detail: 'tasks done',
        color: const Color(0xFF4D8C76),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Proof Signals',
          subtitle: 'Everything RiseUp found in your local memory',
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: signals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.12,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 360 + (index * 80)),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 16 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: _SignalCard(data: signals[index]),
            );
          },
        ),
      ],
    );
  }
}

class _SignalData {
  const _SignalData({
    required this.icon,
    required this.label,
    required this.value,
    required this.detail,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final String detail;
  final Color color;
}

class _SignalCard extends StatelessWidget {
  const _SignalCard({required this.data});

  final _SignalData data;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(data.icon, color: data.color, size: 22),
          ),
          const Spacer(),
          Text(
            data.value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Color(0xFF243C36),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.label,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF243C36),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.detail,
            style: const TextStyle(color: Color(0xFF65706B), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _WeeklyFocusPanel extends StatelessWidget {
  const _WeeklyFocusPanel({required this.summary});

  final ProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    final totalTasks = summary.todos.length;
    final progress = totalTasks > 0 ? (summary.totalCompletedTodos / totalTasks).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'To-Do Proof',
          subtitle: 'Tasks completed from your daily lists',
        ),
        const SizedBox(height: 14),
        _GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${summary.totalCompletedTodos}',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      height: 1,
                      color: Color(0xFF243C36),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      'tasks completed',
                      style: TextStyle(
                        color: Color(0xFF65706B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 850),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: value,
                      backgroundColor: const Color(0xFFE4E9E2),
                      color: const Color(0xFF4D8C76),
                    ),
                  );
                },
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: _MiniMetric(
                      label: 'Total Tasks',
                      value: '${summary.todos.length}',
                      icon: Icons.assignment_rounded,
                      color: const Color(0xFF4D8C76),
                    ),
                  ),
                  Expanded(
                    child: _MiniMetric(
                      label: 'Active days',
                      value: '${summary.activeFocusDays}',
                      icon: Icons.calendar_today_rounded,
                      color: const Color(0xFF5A7FC8),
                    ),
                  ),
                  Expanded(
                    child: _MiniMetric(
                      label: 'Open',
                      value: '${summary.activeTodos.length}',
                      icon: Icons.pending_actions_rounded,
                      color: const Color(0xFFE99572),
                    ),
                  ),
                ],
              ),
              if (summary.todos.isEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'No to-dos yet. Start by creating a task and checking off its subtasks.',
                  style: TextStyle(color: Color(0xFF65706B), height: 1.4),
                ),
              ] else ...[
                const SizedBox(height: 16),
                _RecentFocusList(sessions: summary.todos.take(3).toList()),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RecentFocusList extends StatelessWidget {
  const _RecentFocusList({required this.sessions});

  final List<Todo> sessions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sessions
          .map(
            (todo) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(
                    todo.isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    size: 19,
                    color: const Color(0xFF4D8C76),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF243C36),
                        decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _WeeklyInsightsPanel extends StatelessWidget {
  const _WeeklyInsightsPanel({
    required this.reviews,
    required this.isGenerating,
    required this.hasCompletedTasks,
    required this.onGenerate,
  });

  final List<WeeklyReview> reviews;
  final bool isGenerating;
  final bool hasCompletedTasks;
  final Future<void> Function() onGenerate;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hasReviewThisWeek = reviews.any((r) {
      final diff = now.difference(r.weekStartDate).inDays;
      return diff >= 0 && diff < 7;
    });

    final String buttonLabel;
    final IconData buttonIconData;
    final Color buttonColor;

    if (!hasCompletedTasks) {
      buttonLabel = 'Generate';
      buttonIconData = Icons.lock_outline_rounded;
      buttonColor = const Color(0xFF86928C);
    } else if (hasReviewThisWeek) {
      buttonLabel = 'Regenerate';
      buttonIconData = Icons.refresh_rounded;
      buttonColor = const Color(0xFF25463C);
    } else {
      buttonLabel = 'Generate';
      buttonIconData = Icons.auto_awesome_rounded;
      buttonColor = const Color(0xFF25463C);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          title: 'AI Weekly Insight',
          subtitle: 'Gemini turns your proof into coaching',
          trailing: FilledButton.icon(
            onPressed: isGenerating ? null : onGenerate,
            icon: isGenerating
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(buttonIconData, size: 18),
            label: Text(buttonLabel),
            style: FilledButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (reviews.isEmpty)
          _GlassPanel(
            child: Text(
              hasCompletedTasks
                  ? 'Tap "Generate" to create your personalized AI coaching insight for this week.'
                  : 'Complete at least 1 task from your daily list, then tap Generate to get your personalized AI coaching insight.',
              style: const TextStyle(color: Color(0xFF65706B), height: 1.4),
            ),
          )
        else
          Column(
            children: [
              for (final review in reviews.take(2))
                _WeeklyInsightCard(review: review),
            ],
          ),
      ],
    );
  }
}

class _WeeklyInsightCard extends StatefulWidget {
  const _WeeklyInsightCard({required this.review});

  final WeeklyReview review;

  @override
  State<_WeeklyInsightCard> createState() => _WeeklyInsightCardState();
}

class _WeeklyInsightCardState extends State<_WeeklyInsightCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final review = widget.review;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _GlassPanel(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.insights_rounded, color: Color(0xFFE99572)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Week of ${review.weekStartDate.month}/${review.weekStartDate.day}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF243C36),
                    ),
                  ),
                ),
                Text(
                  '${review.totalFocusMinutes} tasks',
                  style: const TextStyle(
                    color: Color(0xFF65706B),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            AnimatedSize(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: RichText(
                maxLines: _isExpanded ? null : 4,
                overflow:
                    _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                text: TextSpan(
                  children: _boldSpans(
                    review.aiInsights,
                    const TextStyle(
                      height: 1.45,
                      color: Color(0xFF3E4D48),
                      fontSize: 14,
                    ),
                    const TextStyle(
                      height: 1.45,
                      color: Color(0xFF243C36),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF25463C),
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                setState(() => _isExpanded = !_isExpanded);
              },
              icon: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 18,
              ),
              label: Text(_isExpanded ? 'Show less' : 'Read more'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MilestonesPanel extends StatelessWidget {
  const _MilestonesPanel({required this.summary});

  final ProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Milestones',
          subtitle: 'Unlocked by your actual stored actions',
        ),
        const SizedBox(height: 14),
        _AchievementTile(
          icon: Icons.local_fire_department_rounded,
          iconColor: Color(0xFFF28C38),
          title: summary.activeFocusDays >= 1
              ? 'Consistency unlocked'
              : 'Consistency',
          subtitle:
              '${summary.activeFocusDays} ${summary.activeFocusDays == 1 ? 'active day' : 'active days'} this week',
          isUnlocked: summary.activeFocusDays >= 1,
        ),
        if (summary.achievements.isNotEmpty) ...[
          const SizedBox(height: 10),
          _AchievementTile(
            icon: Icons.workspace_premium_rounded,
            title: summary.achievements.first.title,
            subtitle: summary.achievements.first.description,
            isUnlocked: true,
          ),
        ],
      ],
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 19),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF243C36),
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF65706B), fontSize: 12),
        ),
      ],
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isUnlocked,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isUnlocked;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final color = isUnlocked ? const Color(0xFF4D8C76) : const Color(0xFF9CA7A2);
    final displayIconColor = iconColor ?? color;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isUnlocked ? 0.9 : 0.72),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUnlocked
              ? const Color(0xFF4D8C76).withValues(alpha: 0.28)
              : Colors.white.withValues(alpha: 0.88),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF315044).withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: displayIconColor.withValues(
                alpha: isUnlocked ? 0.16 : 0.12,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: displayIconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF243C36),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF65706B),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isUnlocked ? Icons.check_circle_rounded : Icons.lock_outline_rounded,
            color: color,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF20332F),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF65706B),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 10), trailing!],
      ],
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
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

class _ProgressMark extends StatelessWidget {
  const _ProgressMark({this.inverted = false});

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: inverted
              ? const [Colors.white, Color(0xFFFFE7C8)]
              : const [Color(0xFF25463C), Color(0xFF6F9E88)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.auto_graph_rounded,
        color: inverted ? const Color(0xFF25463C) : Colors.white,
      ),
    );
  }
}

class _ProgressLoading extends StatelessWidget {
  const _ProgressLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ProgressError extends StatelessWidget {
  const _ProgressError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 110, 20, 112),
      children: [
        _GlassPanel(
          child: Text(
            'Could not load progress proof: $message',
            style: const TextStyle(color: Color(0xFF65706B)),
          ),
        ),
      ],
    );
  }
}

List<TextSpan> _boldSpans(
  String text,
  TextStyle normalStyle,
  TextStyle boldStyle,
) {
  final spans = <TextSpan>[];
  var cursor = 0;

  while (cursor < text.length) {
    final start = text.indexOf('**', cursor);
    if (start == -1) {
      spans.add(TextSpan(text: text.substring(cursor), style: normalStyle));
      break;
    }

    final end = text.indexOf('**', start + 2);
    if (end == -1) {
      spans.add(TextSpan(text: text.substring(cursor), style: normalStyle));
      break;
    }

    if (start > cursor) {
      spans.add(TextSpan(text: text.substring(cursor, start), style: normalStyle));
    }

    final boldText = text.substring(start + 2, end);
    if (boldText.isEmpty) {
      spans.add(const TextSpan(text: '**'));
    } else {
      spans.add(TextSpan(text: boldText, style: boldStyle));
    }

    cursor = end + 2;
  }

  return spans.isEmpty ? [TextSpan(text: text, style: normalStyle)] : spans;
}

String _activityLabel(ActivityType activity) {
  switch (activity) {
    case ActivityType.inLecture:
      return 'In Lecture';
    case ActivityType.studying:
      return 'Studying';
    case ActivityType.dsa:
      return 'DSA';
    case ActivityType.dbms:
      return 'DBMS';
    case ActivityType.englishPractice:
      return 'English Practice';
    case ActivityType.projectWork:
      return 'Project Work';
    case ActivityType.takingBreak:
      return 'Taking Break';
    case ActivityType.instagram:
      return 'Instagram';
    case ActivityType.youtube:
      return 'YouTube';
    case ActivityType.feelingTired:
      return 'Feeling Tired';
    case ActivityType.feelingLow:
      return 'Feeling Low';
    case ActivityType.other:
      return 'Other';
  }
}

class _ProgressBackdropPainter extends CustomPainter {
  const _ProgressBackdropPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF8F3E7), Color(0xFFEAF4EC), Color(0xFFFFEFE2)],
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
      Offset(size.width * (0.14 + progress * 0.07), size.height * 0.18),
      size.width * 0.58,
    );
    drawGlow(
      const Color(0xFFE99572),
      Offset(size.width * (0.9 - progress * 0.07), size.height * 0.16),
      size.width * 0.48,
    );
    drawGlow(
      const Color(0xFF6F8EDB),
      Offset(size.width * 0.78, size.height * (0.82 - progress * 0.08)),
      size.width * 0.44,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
