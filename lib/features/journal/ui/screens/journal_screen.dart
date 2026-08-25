import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/features/journal/models/reflection.dart';
import 'package:riseup/features/journal/providers/journal_provider.dart';
import 'package:riseup/features/journal/ui/widgets/english_practice_log_widget.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen>
    with TickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _winController = TextEditingController();
  late final AnimationController _ambientController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 11),
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
    _ambientController.dispose();
    _introController.dispose();
    _contentController.dispose();
    _winController.dispose();
    super.dispose();
  }

  Future<void> _saveReflection() async {
    final content = _contentController.text.trim();
    final smallWin = _winController.text.trim();

    if (content.isEmpty || smallWin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add your reflection and one small win.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      await ref.read(journalProvider.notifier).saveReflection(content, smallWin);
      _contentController.clear();
      _winController.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reflection saved. Small win captured.')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reflections = ref.watch(journalProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: const Row(
          children: [
            _JournalMark(),
            SizedBox(width: 10),
            Text(
              'Journal',
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
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ambientController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _JournalBackdropPainter(_ambientController.value),
                );
              },
            ),
          ),
          SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(journalProvider);
                ref.invalidate(englishPracticeLogsProvider);
              },
              child: reflections.when(
                data: (reflectionList) => FadeTransition(
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
                          AnimatedBuilder(
                            animation: _ambientController,
                            builder: (context, _) {
                              return _JournalHero(
                                reflections: reflectionList,
                                progress: _ambientController.value,
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          _ReflectionComposer(
                            contentController: _contentController,
                            winController: _winController,
                            isSaving: _isSaving,
                            onSave: _saveReflection,
                          ),
                          const SizedBox(height: 22),
                          const EnglishPracticeLogWidget(),
                          const SizedBox(height: 24),
                          _RecentReflections(reflections: reflectionList),
                        ],
                      ),
                    ),
                  ),
                ),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (error, _) => _JournalErrorState(
                  message: 'Error: $error',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _JournalHero extends StatelessWidget {
  const _JournalHero({required this.reflections, required this.progress});

  final List<Reflection> reflections;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final reflectionDays = reflections
        .map((reflection) => DateUtils.dateOnly(reflection.date))
        .toSet()
        .length;
    final latestWin = reflections.isEmpty ? null : reflections.first.smallWin;
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
          colors: [Color(0xFF2A4039), Color(0xFF7B9F80), Color(0xFFF2B27A)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2A4039).withValues(alpha: 0.24),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -26 + (progress * 16),
            top: -22,
            child: Icon(
              Icons.edit_note_rounded,
              size: 132,
              color: Colors.white.withValues(alpha: 0.11),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _JournalMark(inverted: true),
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
                    child: Text(
                      '$reflectionDays reflection days',
                      style: const TextStyle(
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
                child: const Text(
                  'Turn today\ninto proof.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    height: 1.04,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                latestWin == null
                    ? 'Write what happened, name one small win, and let RiseUp remember your progress.'
                    : 'Latest small win: $latestWin',
                style: const TextStyle(
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

class _ReflectionComposer extends StatelessWidget {
  const _ReflectionComposer({
    required this.contentController,
    required this.winController,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController contentController;
  final TextEditingController winController;
  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Daily Reflection',
          subtitle: 'A gentle check-out for your mind',
        ),
        const SizedBox(height: 14),
        _GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _FieldLabel(
                icon: Icons.psychology_alt_rounded,
                text: 'How did today feel?',
                color: Color(0xFF4D8C76),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: contentController,
                maxLines: 5,
                decoration: _inputDecoration(
                  'Write thoughts, challenges, distractions, or progress...',
                ),
              ),
              const SizedBox(height: 18),
              const _FieldLabel(
                icon: Icons.workspace_premium_rounded,
                text: 'What is today\'s small win?',
                color: Color(0xFFE99572),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: winController,
                maxLines: 3,
                decoration: _inputDecoration('Even one honest effort counts.'),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF25463C),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: isSaving ? null : onSave,
                  icon: isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save_rounded),
                  label: Text(isSaving ? 'Saving...' : 'Save Reflection'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF243C36),
            ),
          ),
        ),
      ],
    );
  }
}

class _RecentReflections extends StatelessWidget {
  const _RecentReflections({required this.reflections});

  final List<Reflection> reflections;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Recent Reflections',
          subtitle: 'Your small wins, saved as evidence',
        ),
        const SizedBox(height: 14),
        if (reflections.isEmpty)
          const _GlassPanel(
            child: Text(
              'No reflections yet. Save one today and this section will become your growth record.',
              style: TextStyle(color: Color(0xFF65706B), height: 1.4),
            ),
          )
        else
          Column(
            children: [
              for (var index = 0;
                  index < math.min(reflections.length, 5);
                  index++)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 340 + (index * 70)),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 16 * (1 - value)),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: _ReflectionTile(reflection: reflections[index]),
                ),
            ],
          ),
      ],
    );
  }
}

class _ReflectionTile extends StatelessWidget {
  const _ReflectionTile({required this.reflection});

  final Reflection reflection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: _GlassPanel(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF1DD), Color(0xFFE9F4EC)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Color(0xFFE99572),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    reflection.smallWin,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF243C36),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4D8C76).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    _shortDate(reflection.date),
                    style: const TextStyle(
                      color: Color(0xFF4D8C76),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              reflection.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF65706B), height: 1.42),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
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

class _JournalMark extends StatelessWidget {
  const _JournalMark({this.inverted = false});

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
        Icons.edit_note_rounded,
        color: inverted ? const Color(0xFF25463C) : Colors.white,
      ),
    );
  }
}

class _JournalErrorState extends StatelessWidget {
  const _JournalErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, color: Color(0xFFE07165)),
            const SizedBox(width: 10),
            Flexible(child: Text(message)),
          ],
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Color(0xFF8B9691)),
    filled: true,
    fillColor: const Color(0xFFF8FAF6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE1E8E3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFFE1E8E3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF4D8C76), width: 2),
    ),
    contentPadding: const EdgeInsets.all(16),
  );
}

String _shortDate(DateTime date) {
  return '${date.month}/${date.day}';
}

class _JournalBackdropPainter extends CustomPainter {
  const _JournalBackdropPainter(this.progress);

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
      Offset(size.width * (0.16 + progress * 0.06), size.height * 0.2),
      size.width * 0.58,
    );
    drawGlow(
      const Color(0xFFE99572),
      Offset(size.width * (0.9 - progress * 0.07), size.height * 0.16),
      size.width * 0.48,
    );
    drawGlow(
      const Color(0xFF6F8EDB),
      Offset(size.width * 0.76, size.height * (0.82 - progress * 0.08)),
      size.width * 0.44,
    );
  }

  @override
  bool shouldRepaint(covariant _JournalBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
