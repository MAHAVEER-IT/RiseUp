import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/companion/companion_monitoring_service_v2.dart';
import 'package:riseup/features/companion/models/activity_log.dart';
import 'package:riseup/features/companion/providers/companion_provider.dart';

class QuickUpdateSheet extends ConsumerStatefulWidget {
  const QuickUpdateSheet({super.key});

  @override
  ConsumerState<QuickUpdateSheet> createState() => _QuickUpdateSheetState();
}

class _QuickUpdateSheetState extends ConsumerState<QuickUpdateSheet> {
  ActivityType? _selectedActivity;
  final TextEditingController _noteController = TextEditingController();
  int? _moodRating;
  int? _energyLevel;
  bool _isLoading = false;

  final List<ActivityType> activityOptions = [
    ActivityType.inLecture,
    ActivityType.studying,
    ActivityType.dsa,
    ActivityType.dbms,
    ActivityType.englishPractice,
    ActivityType.projectWork,
    ActivityType.takingBreak,
    ActivityType.instagram,
    ActivityType.youtube,
    ActivityType.feelingTired,
    ActivityType.feelingLow,
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitAndGetResponse() async {
    if (_selectedActivity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select what you\'re doing'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final activityName = CompanionMonitoringService.getActivityNameStatic(
        _selectedActivity!,
      );

      // Save activity
      await ref
          .read(companionMonitoringServiceProvider)
          .saveActivityResponse(
            activityType: activityName,
            additionalNote: _noteController.text.isEmpty
                ? null
                : _noteController.text,
            moodRating: _moodRating,
            energyLevel: _energyLevel,
          );

      // Get AI response
      final responses = await ref
          .read(companionAIResponseServiceProvider)
          .generateCompanionResponse(
            activityType: activityName,
            additionalNote: _noteController.text.isEmpty
                ? null
                : _noteController.text,
            moodRating: _moodRating,
            energyLevel: _energyLevel,
          );

      // Show response in a beautiful bottom sheet dialog
      if (mounted) {
        _showAIResponseDialog(
          encouragement: responses['encouragement'] ?? '',
          guidance: responses['guidance'] ?? '',
          focusGuidance: responses['focusGuidance'] ?? '',
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showAIResponseDialog({
    required String encouragement,
    required String guidance,
    required String focusGuidance,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '💙 Here for you',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            _ResponseCard(
              icon: '💙',
              title: 'Encouragement',
              content: encouragement,
            ),
            const SizedBox(height: 12),
            _ResponseCard(icon: '💡', title: 'Guidance', content: guidance),
            const SizedBox(height: 12),
            _ResponseCard(
              icon: '🎯',
              title: 'Next Steps',
              content: focusGuidance,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close response sheet
                  Navigator.pop(context); // Close quick update sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF88A992),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Got it, thank you 🙏',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              const Text(
                'What are you doing right now?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),

              // Activity grid (2 columns)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemCount: activityOptions.length,
                itemBuilder: (context, index) {
                  final activity = activityOptions[index];
                  final isSelected = _selectedActivity == activity;

                  return _ActivityButton(
                    activity: activity,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedActivity = isSelected ? null : activity;
                      });
                    },
                  );
                },
              ),
              const SizedBox(height: 20),

              // Quick mood/energy selector
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How\'s your mood?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (i) {
                            final level = i + 1;
                            return GestureDetector(
                              onTap: () => setState(() {
                                _moodRating = _moodRating == level
                                    ? null
                                    : level;
                              }),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _moodRating == level
                                      ? const Color(
                                          0xFF88A992,
                                        ).withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: _moodRating == level
                                        ? const Color(0xFF88A992)
                                        : const Color(0xFFEEEEEE),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    ['😔', '😞', '😐', '🙂', '😄'][i],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Energy level?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (i) {
                            final level = i + 1;
                            return GestureDetector(
                              onTap: () => setState(() {
                                _energyLevel = _energyLevel == level
                                    ? null
                                    : level;
                              }),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _energyLevel == level
                                      ? const Color(
                                          0xFF88A992,
                                        ).withValues(alpha: 0.2)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: _energyLevel == level
                                        ? const Color(0xFF88A992)
                                        : const Color(0xFFEEEEEE),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    ['😴', '🥱', '😐', '⚡', '🔥'][i],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Optional note field
              TextField(
                controller: _noteController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Optional note (e.g., "just scrolling for 20 min")',
                  hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitAndGetResponse,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF88A992),
                    disabledBackgroundColor: const Color(
                      0xFF88A992,
                    ).withValues(alpha: 0.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'Share & Get Support 💙',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityButton extends StatelessWidget {
  final ActivityType activity;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActivityButton({
    required this.activity,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF88A992).withValues(alpha: 0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF88A992)
                : const Color(0xFFDDDDDD),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              CompanionMonitoringService.getActivityEmojiStatic(activity),
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              CompanionMonitoringService.getActivityNameStatic(activity),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponseCard extends StatelessWidget {
  final String icon;
  final String title;
  final String content;

  const _ResponseCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF444444),
            ),
          ),
        ],
      ),
    );
  }
}
