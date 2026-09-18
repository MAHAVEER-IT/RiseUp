import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/network/gemini_provider.dart';
import 'package:riseup/core/network/gemini_service.dart';
import 'package:riseup/core/notifications/notification_service.dart';
import 'package:riseup/features/companion/models/companion_mode.dart';
import 'package:riseup/features/settings/models/user_profile.dart';
import 'package:riseup/features/settings/providers/user_profile_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _ambientController;
  late final AnimationController _introController;
  late final Animation<double> _introAnimation;

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
    final userProfileState = ref.watch(userProfileProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF7F4ED),
      appBar: AppBar(
        title: const Row(
          children: [
            _SettingsMark(),
            SizedBox(width: 10),
            Text(
              'Settings',
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
                  painter: _SettingsBackdropPainter(_ambientController.value),
                );
              },
            ),
          ),
          SafeArea(
            child: userProfileState.when(
              data: (profile) => RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(userProfileProvider);
                },
                child: FadeTransition(
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
                              return _ProfileHero(
                                profile: profile,
                                progress: _ambientController.value,
                                onEditName: () =>
                                    _editName(context, ref, profile),
                              );
                            },
                          ),
                          const SizedBox(height: 22),
                          _RoutineSection(
                            profile: profile,
                            onEditTime: (label, currentTime, applyTime) {
                              _editTime(
                                context,
                                ref,
                                profile,
                                label,
                                currentTime,
                                applyTime,
                              );
                            },
                          ),
                          const SizedBox(height: 22),
                          const _CompanionSection(),
                          const SizedBox(height: 22),
                          const _AiSettingsSection(),
                          const SizedBox(height: 28),
                          const _DeviceDataNotice(),
                          const SizedBox(height: 36),
                          const Center(
                            child: Text(
                              'Crafted by Mahaveer 💚',
                              style: TextStyle(
                                color: Color(0xFF5B7C70),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _SettingsError(message: 'Error: $error'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editName(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
  ) async {
    final controller = TextEditingController(text: profile.name);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: const Text('Edit Name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (result == null || result.isEmpty) return;
    profile.name = result;
    await ref.read(userProfileProvider.notifier).updateProfile(profile);
  }

  Future<void> _editTime(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
    String label,
    DateTime currentTime,
    void Function(DateTime value) applyTime,
  ) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentTime),
      helpText: 'Set $label time',
    );
    if (pickedTime == null) return;

    applyTime(DateTime(2000, 1, 1, pickedTime.hour, pickedTime.minute));
    await ref.read(userProfileProvider.notifier).updateProfile(profile);
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({
    required this.profile,
    required this.progress,
    required this.onEditName,
  });

  final UserProfile profile;
  final double progress;
  final VoidCallback onEditName;

  @override
  Widget build(BuildContext context) {
    final joinedDays = DateTime.now().difference(profile.createdAt).inDays;
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
            top: -22,
            child: Icon(
              Icons.settings_rounded,
              size: 132,
              color: Colors.white.withValues(alpha: 0.11),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xFFFFE7C8)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        _initials(profile.name),
                        style: const TextStyle(
                          color: Color(0xFF25463C),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.24),
                      ),
                    ),
                    child: IconButton(
                      tooltip: 'Edit name',
                      onPressed: onEditName,
                      icon: const Icon(Icons.edit_rounded, color: Colors.white),
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
                  profile.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                joinedDays <= 0
                    ? 'Your RiseUp journey starts today.'
                    : '$joinedDays days of building your RiseUp story.',
                style: const TextStyle(
                  color: Color(0xFFEAF4EF),
                  fontSize: 15,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18),
              const Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _HeroChip(icon: Icons.school_rounded, label: 'Student mode'),
                  _HeroChip(
                    icon: Icons.psychology_alt_rounded,
                    label: 'AI companion',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _initials(String name) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return 'RU';
    final parts = cleanName.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return '${parts.first.characters.first}${parts.last.characters.first}'
        .toUpperCase();
  }
}

class _DeviceDataNotice extends StatelessWidget {
  const _DeviceDataNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3ED),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFCFE0D5)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.phone_android_rounded,
            size: 20,
            color: Color(0xFF3E7965),
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your data stays on this phone',
                  style: TextStyle(
                    color: Color(0xFF25463C),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'For your privacy, RiseUp stores your information locally. Important: deleting the app or clearing its app data permanently erases your saved data.',
                  style: TextStyle(
                    color: Color(0xFF5D7168),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineSection extends StatelessWidget {
  const _RoutineSection({required this.profile, required this.onEditTime});

  final UserProfile profile;
  final void Function(
    String label,
    DateTime currentTime,
    void Function(DateTime value) applyTime,
  )
  onEditTime;

  @override
  Widget build(BuildContext context) {
    final studyStart = profile.collegeEndTime.add(const Duration(hours: 2));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Daily Rhythm',
          subtitle: 'RiseUp times notifications around this routine',
        ),
        const SizedBox(height: 14),
        _GlassPanel(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _RoutineTile(
                icon: Icons.wb_sunny_rounded,
                title: 'Wake up',
                time: _formatTime(profile.wakeTime),
                color: const Color(0xFFE99572),
                onTap: () => onEditTime(
                  'Wake up',
                  profile.wakeTime,
                  (value) => profile.wakeTime = value,
                ),
              ),
              _RoutineTile(
                icon: Icons.school_rounded,
                title: 'College',
                time:
                    '${_formatTime(profile.collegeStartTime)} - ${_formatTime(profile.collegeEndTime)}',
                color: const Color(0xFF5A7FC8),
                onTap: () => onEditTime(
                  'College start',
                  profile.collegeStartTime,
                  (value) => profile.collegeStartTime = value,
                ),
              ),
              _RoutineTile(
                icon: Icons.menu_book_rounded,
                title: 'Study window',
                time: 'After ${_formatTime(studyStart)}',
                color: const Color(0xFF4D8C76),
                onTap: () => onEditTime(
                  'College end',
                  profile.collegeEndTime,
                  (value) => profile.collegeEndTime = value,
                ),
              ),
              _RoutineTile(
                icon: Icons.nightlight_round,
                title: 'Sleep',
                time: _formatTime(profile.sleepTime),
                color: const Color(0xFFB8864B),
                onTap: () => onEditTime(
                  'Sleep',
                  profile.sleepTime,
                  (value) => profile.sleepTime = value,
                ),
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoutineTile extends StatelessWidget {
  const _RoutineTile({
    required this.icon,
    required this.title,
    required this.time,
    required this.color,
    required this.onTap,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String time;
  final Color color;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: color),
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
                          time,
                          style: const TextStyle(
                            color: Color(0xFF65706B),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9CA7A2),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: 62,
            color: const Color(0xFF315044).withValues(alpha: 0.08),
          ),
      ],
    );
  }
}

class _CompanionSection extends StatelessWidget {
  const _CompanionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'Companion Voice',
          subtitle: 'Notifications that start supportive check-ins',
        ),
        const SizedBox(height: 14),
        _GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _IconBadge(
                    icon: Icons.notifications_active_rounded,
                    color: Color(0xFFE99572),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Balanced check-ins',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF243C36),
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'About every 2 hours during active time',
                          style: TextStyle(
                            color: Color(0xFF65706B),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'RiseUp opens Quick Update, Reflection, or Progress based on the notification you tap.',
                style: TextStyle(color: Color(0xFF65706B), height: 1.4),
              ),
              const SizedBox(height: 16),
              FutureBuilder<NotificationHealth>(
                future: NotificationService.getHealth(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const _NotificationStatusRow(
                      icon: Icons.error_outline_rounded,
                      label: 'Notification status unavailable',
                      color: Color(0xFFE07165),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const _NotificationStatusRow(
                      icon: Icons.sync_rounded,
                      label: 'Checking notification status...',
                      color: Color(0xFF5A7FC8),
                    );
                  }

                  final health = snapshot.data!;
                  return Column(
                    children: [
                      _NotificationStatusRow(
                        icon: health.notificationsEnabled
                            ? Icons.notifications_active_rounded
                            : Icons.notifications_off_rounded,
                        label: health.notificationsEnabled
                            ? 'Notifications enabled'
                            : 'Notifications blocked',
                        color: health.notificationsEnabled
                            ? const Color(0xFF4D8C76)
                            : const Color(0xFFE07165),
                      ),
                      const SizedBox(height: 8),
                      _NotificationStatusRow(
                        icon: Icons.alarm_rounded,
                        label: health.exactAlarmsEnabled
                            ? 'Exact reminder timing enabled'
                            : 'Allow exact alarms for on-time reminders',
                        color: health.exactAlarmsEnabled
                            ? const Color(0xFF4D8C76)
                            : const Color(0xFFE07165),
                      ),
                      const SizedBox(height: 8),
                      _NotificationStatusRow(
                        icon: Icons.schedule_rounded,
                        label:
                            '${health.pendingNotifications} reminders scheduled',
                        color: const Color(0xFF5A7FC8),
                      ),
                      const SizedBox(height: 8),
                      _NotificationStatusRow(
                        icon: Icons.public_rounded,
                        label: 'Timezone: ${health.timezoneName}',
                        color: const Color(0xFFB8864B),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF25463C),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  icon: const Icon(Icons.verified_rounded),
                  onPressed: () async {
                    final granted =
                        await NotificationService.enableCompanionNotifications(
                          mode: CompanionMode.balanced,
                        );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          granted
                              ? 'Companion notifications are enabled and scheduled.'
                              : 'Notification permission still needs attention.',
                        ),
                      ),
                    );
                  },
                  label: const Text('Check Notification Permission'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  icon: const Icon(Icons.notifications_rounded),
                  onPressed: () async {
                    await NotificationService.showTestNotification();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Test notification sent.')),
                    );
                  },
                  label: const Text('Send Test Notification 🔔'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotificationStatusRow extends StatelessWidget {
  const _NotificationStatusRow({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 17),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF4F5754),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
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
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 22),
    );
  }
}

class _SettingsMark extends StatelessWidget {
  const _SettingsMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF25463C), Color(0xFF6F9E88)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.settings_rounded, color: Colors.white),
    );
  }
}

class _SettingsError extends StatelessWidget {
  const _SettingsError({required this.message});

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

String _formatTime(DateTime value) {
  final hour = value.hour;
  final minute = value.minute.toString().padLeft(2, '0');
  final period = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour % 12 == 0 ? 12 : hour % 12;
  return '$displayHour:$minute $period';
}

String _friendlyDate(DateTime value) {
  return '${value.day}/${value.month}/${value.year}';
}

class _SettingsBackdropPainter extends CustomPainter {
  const _SettingsBackdropPainter(this.progress);

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
  bool shouldRepaint(covariant _SettingsBackdropPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _AiSettingsSection extends ConsumerStatefulWidget {
  const _AiSettingsSection();

  @override
  ConsumerState<_AiSettingsSection> createState() => _AiSettingsSectionState();
}

class _AiSettingsSectionState extends ConsumerState<_AiSettingsSection> {
  bool _isTestingKey = false;

  Future<void> _testCurrentKey(String key) async {
    setState(() => _isTestingKey = true);
    final status = await GeminiService.testApiKey(key);
    if (!mounted) return;
    setState(() => _isTestingKey = false);

    if (status == ApiKeyValidationStatus.valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gemini API key is working properly! ✨'),
          backgroundColor: Color(0xFF25463C),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else if (status == ApiKeyValidationStatus.serverBusy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Google is busy, try again.'),
          backgroundColor: Color(0xFFD97706),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'API key test failed. Please verify your key with Google AI Studio.',
          ),
          backgroundColor: Color(0xFFD9534F),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _confirmRemoveKey() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'Remove Gemini API Key?',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF20332F),
          ),
        ),
        content: const Text(
          'Removing your key will disable AI Chat and Weekly Insights until you add a new key.',
          style: TextStyle(color: Color(0xFF65706B), height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF65706B)),
            ),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await ref.read(geminiApiKeyProvider.notifier).removeApiKey();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Gemini API key removed from device.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFD9534F),
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showKeyDialog([String? existingKey]) {
    showDialog(
      context: context,
      builder: (dialogContext) => _ApiKeyEntryDialog(existingKey: existingKey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyAsync = ref.watch(geminiApiKeyProvider);
    final currentKey = keyAsync.value;
    final hasKey = currentKey != null && currentKey.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          title: 'AI Companion & Privacy',
          subtitle: 'Direct Google Gemini integration stored on-device',
        ),
        const SizedBox(height: 14),
        _GlassPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _IconBadge(
                    icon: Icons.auto_awesome_rounded,
                    color: hasKey
                        ? const Color(0xFF4D8C76)
                        : const Color(0xFF86928C),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Google Gemini Flash',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF243C36),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          hasKey
                              ? 'Active • Encrypted on device'
                              : 'Not configured • Key required for AI',
                          style: const TextStyle(
                            color: Color(0xFF65706B),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: (hasKey
                              ? const Color(0xFF4D8C76)
                              : const Color(0xFF86928C))
                          .withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      hasKey ? 'Active' : 'Disabled',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: hasKey
                            ? const Color(0xFF2E6351)
                            : const Color(0xFF5B6963),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (hasKey) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6F2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E7DF)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.key_rounded,
                        size: 16,
                        color: Color(0xFF4D8C76),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          currentKey.length > 8
                              ? '${currentKey.substring(0, 6)}••••••••${currentKey.substring(currentKey.length - 4)}'
                              : '••••••••',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E4D40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _isTestingKey
                          ? null
                          : () => _testCurrentKey(currentKey),
                      icon: _isTestingKey
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xFF25463C),
                              ),
                            )
                          : const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 16,
                            ),
                      label: const Text('Test key'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF25463C),
                        side: const BorderSide(color: Color(0xFFC7D3CD)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _showKeyDialog(currentKey),
                      icon: const Icon(Icons.edit_rounded, size: 16),
                      label: const Text('Change key'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF25463C),
                        side: const BorderSide(color: Color(0xFFC7D3CD)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: _confirmRemoveKey,
                      icon: const Icon(Icons.delete_outline_rounded, size: 16),
                      label: const Text('Remove key'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFD9534F),
                        side: const BorderSide(color: Color(0xFFF0B8B6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                const Text(
                  'No API key configured. Provide your free Gemini key to unlock AI Chat companion and Weekly Reviews.',
                  style: TextStyle(color: Color(0xFF65706B), height: 1.4),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () => _showKeyDialog(),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Set Up Gemini Key'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF25463C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F2EC).withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF4D8C76).withValues(alpha: 0.2),
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 18,
                      color: Color(0xFF25463C),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your key stays on this device. AI requests are sent directly to Google Gemini.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF385248),
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ApiKeyEntryDialog extends ConsumerStatefulWidget {
  const _ApiKeyEntryDialog({this.existingKey});

  final String? existingKey;

  @override
  ConsumerState<_ApiKeyEntryDialog> createState() => _ApiKeyEntryDialogState();
}

class _ApiKeyEntryDialogState extends ConsumerState<_ApiKeyEntryDialog> {
  late final TextEditingController _controller;
  bool _isObscured = true;
  bool _isValidating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.existingKey ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null && data!.text!.trim().isNotEmpty) {
      setState(() {
        _controller.text = data.text!.trim();
        _error = null;
      });
    }
  }

  Future<void> _openStudio() async {
    final uri = Uri.parse('https://aistudio.google.com/app/apikey');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  Future<void> _save() async {
    final key = _controller.text.trim();
    if (key.isEmpty) {
      setState(() => _error = 'Please enter an API key');
      return;
    }

    setState(() {
      _isValidating = true;
      _error = null;
    });

    final status = await GeminiService.testApiKey(key);
    if (!mounted) return;

    if (status == ApiKeyValidationStatus.valid) {
      await ref.read(geminiApiKeyProvider.notifier).setApiKey(key);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gemini API key saved successfully! ✨'),
            backgroundColor: Color(0xFF25463C),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      setState(() {
        _isValidating = false;
        if (status == ApiKeyValidationStatus.serverBusy) {
          _error = 'Google is busy, try again.';
        } else {
          _error =
              'Could not verify API key with Google. Please check the key and try again.';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Text(
        widget.existingKey == null
            ? 'Set Up Gemini API Key'
            : 'Change Gemini API Key',
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF20332F),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your personal Google Gemini API key to activate AI features.',
              style: TextStyle(
                color: Color(0xFF65706B),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              obscureText: _isObscured,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: 'AIzaSy...',
                filled: true,
                fillColor: const Color(0xFFF7F5EE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isObscured
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                        color: const Color(0xFF65706B),
                      ),
                      onPressed: () =>
                          setState(() => _isObscured = !_isObscured),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.content_paste_rounded,
                        size: 18,
                        color: Color(0xFF4D8C76),
                      ),
                      onPressed: _paste,
                      tooltip: 'Paste',
                    ),
                  ],
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _openStudio,
              icon: const Icon(Icons.open_in_new_rounded, size: 15),
              label: const Text('Get API key from Google AI Studio'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4D8C76),
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isValidating ? null : () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xFF65706B)),
          ),
        ),
        FilledButton(
          onPressed: _isValidating ? null : _save,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF25463C),
          ),
          child: _isValidating
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Save & Verify'),
        ),
      ],
    );
  }
}
