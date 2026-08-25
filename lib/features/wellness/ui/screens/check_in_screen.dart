import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riseup/features/wellness/providers/wellness_provider.dart';

class CheckInScreen extends ConsumerStatefulWidget {
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen>
    with TickerProviderStateMixin {
  final TextEditingController _customNoteController = TextEditingController();
  late final AnimationController _ambientController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;

  int _mood = 3;
  int _energy = 3;
  final Set<String> _selectedContext = {};

  static const List<_ContextOption> _contextOptions = [
    _ContextOption('Poor sleep', Icons.bedtime_rounded, Color(0xFF5A7FC8)),
    _ContextOption('Class pressure', Icons.school_rounded, Color(0xFF4D8C76)),
    _ContextOption('Assignment due', Icons.assignment_rounded, Color(0xFFE99572)),
    _ContextOption('Exam prep', Icons.menu_book_rounded, Color(0xFFB8864B)),
    _ContextOption('Family work', Icons.home_rounded, Color(0xFF4D8C76)),
    _ContextOption('Long commute', Icons.directions_bus_rounded, Color(0xFF5A7FC8)),
    _ContextOption('Phone distraction', Icons.phone_android_rounded, Color(0xFFE07165)),
    _ContextOption('Feeling unwell', Icons.healing_rounded, Color(0xFFE07165)),
    _ContextOption('Money stress', Icons.account_balance_wallet_rounded, Color(0xFFB8864B)),
    _ContextOption('Friend or relationship', Icons.people_rounded, Color(0xFFE99572)),
    _ContextOption('Low confidence', Icons.psychology_alt_rounded, Color(0xFF5A7FC8)),
    _ContextOption('Good momentum', Icons.trending_up_rounded, Color(0xFF4D8C76)),
    _ContextOption('Quiet normal day', Icons.spa_rounded, Color(0xFF4D8C76)),
    _ContextOption('Workout or walk', Icons.directions_walk_rounded, Color(0xFFE99572)),
    _ContextOption('Helped someone', Icons.volunteer_activism_rounded, Color(0xFFB8864B)),
  ];

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
    _customNoteController.dispose();
    _introController.dispose();
    _ambientController.dispose();
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

  String _getMoodText(int moodScore) {
    switch (moodScore) {
      case 1:
        return 'Heavy';
      case 2:
        return 'Low';
      case 3:
        return 'Steady';
      case 4:
        return 'Good';
      case 5:
        return 'Great';
      default:
        return 'Steady';
    }
  }

  String _getRecommendation(int energyScore) {
    if (energyScore < 3) {
      return 'It is okay to keep today light. Try one 5-minute easy win, then rest without guilt.';
    }
    return 'You have solid energy. A 30-minute focus session would be a good next step.';
  }

  String? _buildContextNote() {
    final customNote = _customNoteController.text.trim();
    final parts = <String>[];

    if (_selectedContext.isNotEmpty) {
      parts.add('Context: ${_selectedContext.join(', ')}');
    }
    if (customNote.isNotEmpty) {
      parts.add('Anything else: $customNote');
    }

    return parts.isEmpty ? null : parts.join('\n');
  }

  void _submitCheckIn() {
    ref.read(todayCheckInProvider.notifier).submitMorningCheckIn(
          _mood,
          _energy,
          note: _buildContextNote(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final checkInState = ref.watch(todayCheckInProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: const Row(
          children: [
            _CheckInMark(),
            SizedBox(width: 10),
            Text(
              'Quick Check-In',
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
                  painter: _CheckInBackdropPainter(_ambientController.value),
                ),
              ),
              SafeArea(
                child: checkInState.when(
                  data: (checkIn) {
                    if (checkIn.morningCompleted) {
                      return _CompletedCheckIn(
                        moodText: _getMoodText(checkIn.moodScore),
                        energyText: _getEnergyText(checkIn.energyScore),
                        recommendation: _getRecommendation(checkIn.energyScore),
                      );
                    }

                    return FadeTransition(
                      opacity: _introAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.035),
                          end: Offset.zero,
                        ).animate(_introAnimation),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 112),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _CheckInHero(progress: _ambientController.value),
                              const SizedBox(height: 22),
                              _ScorePanel(
                                title: 'Mood',
                                subtitle: _getMoodText(_mood),
                                value: _mood,
                                lowLabel: 'Heavy',
                                highLabel: 'Great',
                                icon: Icons.mood_rounded,
                                color: const Color(0xFF4D8C76),
                                onChanged: (value) {
                                  setState(() => _mood = value);
                                },
                              ),
                              const SizedBox(height: 16),
                              _ScorePanel(
                                title: 'Energy',
                                subtitle: _getEnergyText(_energy),
                                value: _energy,
                                lowLabel: 'Very low',
                                highLabel: 'Excellent',
                                icon: Icons.bolt_rounded,
                                color: const Color(0xFFE99572),
                                onChanged: (value) {
                                  setState(() => _energy = value);
                                },
                              ),
                              const SizedBox(height: 22),
                              _ContextPanel(
                                options: _contextOptions,
                                selected: _selectedContext,
                                customNoteController: _customNoteController,
                                onToggle: (label) {
                                  setState(() {
                                    if (_selectedContext.contains(label)) {
                                      _selectedContext.remove(label);
                                    } else {
                                      _selectedContext.add(label);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 22),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF25463C),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                  ),
                                  icon: const Icon(Icons.check_rounded),
                                  onPressed: _submitCheckIn,
                                  label: const Text('Save Check-In'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => _CheckInError(message: 'Error: $error'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CheckInHero extends StatelessWidget {
  const _CheckInHero({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
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
          colors: [Color(0xFF243C36), Color(0xFF638F7B), Color(0xFFF0B08D)],
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
            right: -28 + (progress * 16),
            top: -28,
            child: Icon(
              Icons.wb_sunny_rounded,
              size: 136,
              color: Colors.white.withValues(alpha: 0.11),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _CheckInMark(inverted: true),
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
                  'Be honest\nwith today.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    height: 1.04,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'No perfect answer needed. Name the real state, then choose one kind next step.',
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

class _ScorePanel extends StatelessWidget {
  const _ScorePanel({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.lowLabel,
    required this.highLabel,
    required this.icon,
    required this.color,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final int value;
  final String lowLabel;
  final String highLabel;
  final IconData icon;
  final Color color;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBadge(icon: icon, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF243C36),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF65706B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$value/5',
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: color.withValues(alpha: 0.16),
              thumbColor: color,
              overlayColor: color.withValues(alpha: 0.14),
              trackHeight: 8,
            ),
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (newValue) => onChanged(newValue.toInt()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(lowLabel, style: const TextStyle(color: Color(0xFF65706B))),
              Text(highLabel, style: const TextStyle(color: Color(0xFF65706B))),
            ],
          ),
        ],
      ),
    );
  }
}

class _ContextPanel extends StatelessWidget {
  const _ContextPanel({
    required this.options,
    required this.selected,
    required this.customNoteController,
    required this.onToggle,
  });

  final List<_ContextOption> options;
  final Set<String> selected;
  final TextEditingController customNoteController;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'What is affecting today?',
          subtitle: 'Pick any that fit, or skip them and write your own.',
        ),
        const SizedBox(height: 14),
        _GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: options.map((option) {
                  final isSelected = selected.contains(option.label);
                  return _ContextChip(
                    option: option,
                    selected: isSelected,
                    onTap: () => onToggle(option.label),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              const _FieldLabel(
                icon: Icons.edit_note_rounded,
                text: 'Anything else',
                color: Color(0xFF5A7FC8),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: customNoteController,
                minLines: 2,
                maxLines: 5,
                decoration: _inputDecoration(
                  'Write exactly what is true. This can be used alone.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContextChip extends StatelessWidget {
  const _ContextChip({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _ContextOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? option.color : Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? option.color : const Color(0xFFE1E8E3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                option.icon,
                size: 16,
                color: selected ? Colors.white : option.color,
              ),
              const SizedBox(width: 6),
              Text(
                option.label,
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF243C36),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompletedCheckIn extends StatelessWidget {
  const _CompletedCheckIn({
    required this.moodText,
    required this.energyText,
    required this.recommendation,
  });

  final String moodText;
  final String energyText;
  final String recommendation;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 42, 20, 112),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF243C36), Color(0xFF638F7B)],
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
            child: Column(
              children: [
                const _CheckInMark(inverted: true),
                const SizedBox(height: 18),
                const Text(
                  'All set.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Morning check-in complete',
                  style: TextStyle(
                    color: Color(0xFFEAF4EF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _GlassPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatusLine(
                  icon: Icons.mood_rounded,
                  label: 'Mood',
                  value: moodText,
                  color: const Color(0xFF4D8C76),
                ),
                const SizedBox(height: 12),
                _StatusLine(
                  icon: Icons.bolt_rounded,
                  label: 'Energy',
                  value: energyText,
                  color: const Color(0xFFE99572),
                ),
                const SizedBox(height: 16),
                Text(
                  recommendation,
                  style: const TextStyle(
                    color: Color(0xFF65706B),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF25463C),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              icon: const Icon(Icons.home_rounded),
              onPressed: () => context.go('/home'),
              label: const Text('Back to Home'),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              icon: const Icon(Icons.chat_bubble_rounded),
              onPressed: () => context.push('/ai-chat'),
              label: const Text('Chat with AI Mentor'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconBadge(icon: icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF65706B),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF243C36),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
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
        _IconBadge(icon: icon, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF243C36),
            ),
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

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 21),
    );
  }
}

class _CheckInMark extends StatelessWidget {
  const _CheckInMark({this.inverted = false});

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
        Icons.check_circle_rounded,
        color: inverted ? const Color(0xFF25463C) : Colors.white,
      ),
    );
  }
}

class _CheckInError extends StatelessWidget {
  const _CheckInError({required this.message});

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
      borderSide: const BorderSide(color: Color(0xFF5A7FC8), width: 2),
    ),
    contentPadding: const EdgeInsets.all(16),
  );
}

class _ContextOption {
  const _ContextOption(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

class _CheckInBackdropPainter extends CustomPainter {
  const _CheckInBackdropPainter(this.progress);

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
  bool shouldRepaint(covariant _CheckInBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
