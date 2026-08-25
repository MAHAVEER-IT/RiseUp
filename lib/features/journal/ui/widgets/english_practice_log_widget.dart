import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/features/journal/models/english_practice_speaking_log.dart';
import 'package:riseup/features/journal/providers/journal_provider.dart';

class EnglishPracticeLogWidget extends ConsumerStatefulWidget {
  const EnglishPracticeLogWidget({super.key});

  @override
  ConsumerState<EnglishPracticeLogWidget> createState() =>
      _EnglishPracticeLogWidgetState();
}

class _EnglishPracticeLogWidgetState
    extends ConsumerState<EnglishPracticeLogWidget> {
  bool _isExpanded = false;
  bool _isSaving = false;
  int _durationMinutes = 15;
  PracticeMedium _selectedMedium = PracticeMedium.conversation;
  int? _fluencyRating;
  int? _confidenceRating;
  int? _comprensionRating;

  final _topicController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _topicController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _savePracticeLog() async {
    setState(() => _isSaving = true);
    try {
      await ref
          .read(englishPracticeLogsProvider.notifier)
          .savePracticeLog(
            _durationMinutes,
            _selectedMedium,
            topic: _topicController.text.trim().isEmpty
                ? null
                : _topicController.text.trim(),
            notes: _notesController.text.trim().isEmpty
                ? null
                : _notesController.text.trim(),
            fluencyRating: _fluencyRating,
            confidenceRating: _confidenceRating,
            comprensionRating: _comprensionRating,
          );

      _topicController.clear();
      _notesController.clear();
      setState(() {
        _isExpanded = false;
        _durationMinutes = 15;
        _selectedMedium = PracticeMedium.conversation;
        _fluencyRating = null;
        _confidenceRating = null;
        _comprensionRating = null;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('English practice logged. Nice work.')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final practiceLogsAsync = ref.watch(englishPracticeLogsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'English Practice',
          subtitle: 'Build confidence through small speaking reps',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF3DF), Color(0xFFE9F4EC)],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF315044).withValues(alpha: 0.08),
                blurRadius: 26,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.82),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.record_voice_over_rounded,
                      color: Color(0xFFE99572),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: practiceLogsAsync.when(
                      data: (logs) {
                        final totalMinutes = logs.fold<int>(
                          0,
                          (sum, log) => sum + log.durationMinutes,
                        );
                        final streak = logs.isEmpty ? 0 : logs.first.streakDays;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$totalMinutes minutes practiced',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF243C36),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Current streak: $streak days',
                              style: const TextStyle(
                                color: Color(0xFF6F7674),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () => const Text('Loading practice memory...'),
                      error: (_, _) => const Text('Practice memory unavailable'),
                    ),
                  ),
                  IconButton(
                    tooltip: _isExpanded ? 'Close' : 'Add practice',
                    onPressed: () => setState(() => _isExpanded = !_isExpanded),
                    icon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.add_circle_outline,
                      color: const Color(0xFF25463C),
                    ),
                  ),
                ],
              ),
              if (_isExpanded) ...[
                const SizedBox(height: 18),
                const _FieldLabel(text: 'Duration'),
                const SizedBox(height: 8),
                Row(
                  children: [5, 15, 30, 60].map((minutes) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _ChoicePill(
                          label: '${minutes}m',
                          selected: _durationMinutes == minutes,
                          onTap: () =>
                              setState(() => _durationMinutes = minutes),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const _FieldLabel(text: 'Practice type'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    PracticeMedium.conversation,
                    PracticeMedium.videoCall,
                    PracticeMedium.voiceRecording,
                    PracticeMedium.monologue,
                  ].map((medium) {
                    return _ChoicePill(
                      label: _mediumLabel(medium),
                      selected: _selectedMedium == medium,
                      onTap: () => setState(() => _selectedMedium = medium),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _topicController,
                  decoration: _inputDecoration(
                    'Topic, for example interview intro',
                  ),
                ),
                const SizedBox(height: 12),
                _RatingRow(
                  label: 'Fluency',
                  rating: _fluencyRating,
                  onChanged: (value) => setState(() => _fluencyRating = value),
                ),
                _RatingRow(
                  label: 'Confidence',
                  rating: _confidenceRating,
                  onChanged: (value) =>
                      setState(() => _confidenceRating = value),
                ),
                _RatingRow(
                  label: 'Understanding',
                  rating: _comprensionRating,
                  onChanged: (value) =>
                      setState(() => _comprensionRating = value),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notesController,
                  decoration: _inputDecoration(
                    'What went well? What should improve?',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25463C),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: _isSaving ? null : _savePracticeLog,
                    icon: _isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(_isSaving ? 'Saving...' : 'Log Practice'),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),
        practiceLogsAsync.when(
          data: (logs) {
            if (logs.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: _softPanelDecoration(),
                child: const Text(
                  'No speaking logs yet. A 5-minute practice is enough to begin.',
                  style: TextStyle(color: Color(0xFF65706B), height: 1.4),
                ),
              );
            }

            return Column(
              children: logs.take(3).map((log) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.86),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white),
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
                      const Icon(
                        Icons.mic_rounded,
                        color: Color(0xFFE99572),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${log.durationMinutes} min ${_mediumLabel(log.medium)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (log.topic != null) ...[
                              const SizedBox(height: 3),
                              Text(
                                log.topic!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF6F7674),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Text(
                        '${log.timestamp.month}/${log.timestamp.day}',
                        style: const TextStyle(
                          color: Color(0xFF979B9A),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Text('Error: $error'),
        ),
      ],
    );
  }
}

class _ChoicePill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ChoicePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF25463C) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? const Color(0xFF25463C) : const Color(0xFFE1E8E3),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF243C36),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final String label;
  final int? rating;
  final ValueChanged<int> onChanged;

  const _RatingRow({
    required this.label,
    required this.rating,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            children: List.generate(5, (index) {
              final value = index + 1;
              return InkWell(
                onTap: () => onChanged(value),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Icon(
                    Icons.star_rounded,
                    color: rating != null && rating! >= value
                        ? const Color(0xFFE99572)
                        : const Color(0xFFD7DDDA),
                    size: 22,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w700));
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({required this.title, required this.subtitle});

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

InputDecoration _inputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Color(0xFF8B9691)),
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.9),
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
      borderSide: const BorderSide(color: Color(0xFFE99572), width: 2),
    ),
    contentPadding: const EdgeInsets.all(14),
  );
}

BoxDecoration _softPanelDecoration() {
  return BoxDecoration(
    color: Colors.white.withValues(alpha: 0.84),
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.white.withValues(alpha: 0.88)),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF315044).withValues(alpha: 0.06),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );
}

String _mediumLabel(PracticeMedium medium) {
  switch (medium) {
    case PracticeMedium.conversation:
      return 'Conversation';
    case PracticeMedium.videoCall:
      return 'Video call';
    case PracticeMedium.voiceRecording:
      return 'Recording';
    case PracticeMedium.monologue:
      return 'Monologue';
    case PracticeMedium.classroom:
      return 'Classroom';
    case PracticeMedium.other:
      return 'Other';
  }
}
