import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/companion/companion_monitoring_service.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'package:riseup/features/companion/providers/companion_provider.dart';

class QuickUpdateScreen extends ConsumerStatefulWidget {
  const QuickUpdateScreen({super.key});

  @override
  ConsumerState<QuickUpdateScreen> createState() => _QuickUpdateScreenState();
}

class _QuickUpdateScreenState extends ConsumerState<QuickUpdateScreen>
    with TickerProviderStateMixin {
  final TextEditingController _noteController = TextEditingController();
  late final AnimationController _ambientController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;

  ActivityType? _selectedActivity;
  bool _isLoading = false;

  static const List<_ActivityOption> _activityOptions = [
    _ActivityOption(ActivityType.inLecture, 'In lecture', Icons.school_rounded, Color(0xFF5A7FC8)),
    _ActivityOption(ActivityType.studying, 'Studying', Icons.menu_book_rounded, Color(0xFF4D8C76)),
    _ActivityOption(ActivityType.dsa, 'DSA', Icons.data_object_rounded, Color(0xFFB8864B)),
    _ActivityOption(ActivityType.dbms, 'DBMS', Icons.storage_rounded, Color(0xFF5A7FC8)),
    _ActivityOption(ActivityType.englishPractice, 'English practice', Icons.record_voice_over_rounded, Color(0xFFE99572)),
    _ActivityOption(ActivityType.projectWork, 'Project work', Icons.laptop_mac_rounded, Color(0xFF4D8C76)),
    _ActivityOption(ActivityType.takingBreak, 'Taking break', Icons.local_cafe_rounded, Color(0xFFB8864B)),
    _ActivityOption(ActivityType.instagram, 'Instagram', Icons.phone_android_rounded, Color(0xFFE07165)),
    _ActivityOption(ActivityType.youtube, 'YouTube', Icons.smart_display_rounded, Color(0xFFE07165)),
    _ActivityOption(ActivityType.feelingTired, 'Feeling tired', Icons.bedtime_rounded, Color(0xFF5A7FC8)),
    _ActivityOption(ActivityType.feelingLow, 'Feeling low', Icons.cloud_rounded, Color(0xFFE99572)),
    _ActivityOption(ActivityType.other, 'Other', Icons.edit_note_rounded, Color(0xFF4D8C76)),
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
    _noteController.dispose();
    _introController.dispose();
    _ambientController.dispose();
    super.dispose();
  }

  Future<void> _saveAndGetResponse() async {
    final note = _noteController.text.trim();
    final activity = _selectedActivity ?? (note.isNotEmpty ? ActivityType.other : null);

    if (activity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select an option or write what is true.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final activityName = CompanionMonitoringService.getActivityNameStatic(activity);
      final additionalNote = note.isEmpty ? null : note;

      await ref.read(companionMonitoringServiceProvider).saveActivityResponse(
            activityType: activityName,
            additionalNote: additionalNote,
          );

      final responses = await ref
          .read(companionAIResponseServiceProvider)
          .generateCompanionResponse(
            activityType: activityName,
            additionalNote: additionalNote,
          );

      if (!mounted) return;
      setState(() => _isLoading = false);
      _showAIResponseDialog(
        encouragement: responses['encouragement'] ?? '',
        suggestion: responses['suggestion'] ?? '',
        focusGuidance: responses['focusGuidance'] ?? '',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  void _showAIResponseDialog({
    required String encouragement,
    required String suggestion,
    required String focusGuidance,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: const Row(
          children: [
            _QuickUpdateMark(),
            SizedBox(width: 10),
            Text('RiseUp Companion'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ResponseCard(
                icon: Icons.favorite_rounded,
                color: Color(0xFF4D8C76),
                label: 'Encouragement',
                text: encouragement,
              ),
              const SizedBox(height: 12),
              _ResponseCard(
                icon: Icons.lightbulb_rounded,
                color: Color(0xFFE99572),
                label: 'Suggestion',
                text: suggestion,
              ),
              const SizedBox(height: 12),
              _ResponseCard(
                icon: Icons.track_changes_rounded,
                color: Color(0xFF5A7FC8),
                label: 'Focus Guidance',
                text: focusGuidance,
              ),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    ).then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: const Row(
          children: [
            _QuickUpdateMark(),
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
                  painter: _QuickUpdateBackdropPainter(_ambientController.value),
                ),
              ),
              SafeArea(
                child: FadeTransition(
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
                          _QuickUpdateHero(progress: _ambientController.value),
                          const SizedBox(height: 22),
                          const _SectionTitle(
                            title: 'What is happening now?',
                            subtitle: 'Pick one if it fits. If not, just write your truth below.',
                          ),
                          const SizedBox(height: 14),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.24,
                            ),
                            itemCount: _activityOptions.length,
                            itemBuilder: (context, index) {
                              final option = _activityOptions[index];
                              return _ActivityButton(
                                option: option,
                                isSelected: _selectedActivity == option.type,
                                onTap: () {
                                  setState(() {
                                    _selectedActivity =
                                        _selectedActivity == option.type
                                            ? null
                                            : option.type;
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 22),
                          _GlassPanel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const _FieldLabel(
                                  icon: Icons.edit_note_rounded,
                                  text: 'Anything else',
                                  color: Color(0xFF5A7FC8),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  controller: _noteController,
                                  minLines: 3,
                                  maxLines: 6,
                                  decoration: _inputDecoration(
                                    'If none of the options fit, write only this. It still counts.',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF25463C),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed: _isLoading ? null : _saveAndGetResponse,
                              icon: _isLoading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.auto_awesome_rounded),
                              label: Text(
                                _isLoading
                                    ? 'Listening...'
                                    : 'Share & Get Support',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _QuickUpdateHero extends StatelessWidget {
  const _QuickUpdateHero({required this.progress});

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
              Icons.forum_rounded,
              size: 136,
              color: Colors.white.withValues(alpha: 0.11),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _QuickUpdateMark(inverted: true),
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
                  'Say the\nreal thing.',
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
                'A quick update should match your life, not force it into a box.',
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

class _ActivityButton extends StatelessWidget {
  const _ActivityButton({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _ActivityOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? option.color : Colors.white.withValues(alpha: 0.84),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? option.color : Colors.white.withValues(alpha: 0.9),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF315044).withValues(alpha: 0.06),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                option.icon,
                color: isSelected ? Colors.white : option.color,
                size: 24,
              ),
              Text(
                option.label,
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF243C36),
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResponseCard extends StatelessWidget {
  const _ResponseCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF243C36),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: Color(0xFF3E4D48),
            ),
          ),
        ],
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

class _QuickUpdateMark extends StatelessWidget {
  const _QuickUpdateMark({this.inverted = false});

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
        Icons.forum_rounded,
        color: inverted ? const Color(0xFF25463C) : Colors.white,
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

class _ActivityOption {
  const _ActivityOption(this.type, this.label, this.icon, this.color);

  final ActivityType type;
  final String label;
  final IconData icon;
  final Color color;
}

class _QuickUpdateBackdropPainter extends CustomPainter {
  const _QuickUpdateBackdropPainter(this.progress);

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
  bool shouldRepaint(covariant _QuickUpdateBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
