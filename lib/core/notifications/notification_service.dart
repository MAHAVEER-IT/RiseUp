import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:riseup/core/router/app_router.dart';
import 'package:riseup/features/companion/models/companion_mode.dart';
import 'package:riseup/features/companion/models/time_window_config.dart';
import 'package:riseup/features/goals/models/todo.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHealth {
  final bool notificationsEnabled;
  final bool exactAlarmsEnabled;
  final int pendingNotifications;
  final String timezoneName;

  const NotificationHealth({
    required this.notificationsEnabled,
    required this.exactAlarmsEnabled,
    required this.pendingNotifications,
    required this.timezoneName,
  });
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  NotificationService.storePendingPayload(response.payload);
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String companionPayload = 'quick-update';
  static const String reflectionPayload = 'journal';
  static const String weeklyReviewPayload = 'progress';
  static const String moodPayload = 'check-in';
  static const String homePayload = 'home';

  static const String _companionChannelId = 'riseup_companion_channel';
  static const String _reflectionChannelId = 'riseup_reflection_channel';
  static const String _achievementChannelId = 'riseup_achievement_channel';
  static const Duration _platformCallTimeout = Duration(seconds: 4);

  static const int _companionNotificationStartId = 5000;
  static const int _companionNotificationEndId = 5099;
  static const int _reflectionNotificationId = 6100;
  static const int _weeklyReviewNotificationId = 6200;
  static const int _moodReminderNotificationId = 6300;
  static const int _achievementNotificationId = 7000;

  static String? _pendingPayload;
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    await _configureLocalTimezone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    final launchDetails = await _notificationsPlugin
        .getNotificationAppLaunchDetails()
        .timeout(_platformCallTimeout, onTimeout: () => null);
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _pendingPayload =
          launchDetails?.notificationResponse?.payload ?? companionPayload;
    }

    await _notificationsPlugin
        .initialize(
          settings: initializationSettings,
          onDidReceiveNotificationResponse: _handleNotificationResponse,
          onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
        )
        .timeout(_platformCallTimeout);

    await _createNotificationChannels().timeout(_platformCallTimeout);
    _initialized = true;
  }

  static Future<bool> requestPermissions() async {
    final androidImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    final notificationsGranted =
        await androidImplementation
            ?.requestNotificationsPermission()
            .timeout(_platformCallTimeout, onTimeout: () => false) ??
        true;

    final iosImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    final iosGranted =
        await iosImplementation
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            )
            .timeout(_platformCallTimeout, onTimeout: () => false) ??
        true;

    return notificationsGranted && iosGranted;
  }

  static Future<bool> enableCompanionNotifications({
    CompanionMode mode = CompanionMode.balanced,
  }) async {
    await init();
    final granted = await requestPermissions();
    if (!granted) return false;

    await scheduleMvpNotificationPlan(mode: mode);
    return true;
  }

  static Future<NotificationHealth> getHealth() async {
    await init();

    final androidImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    final notificationsEnabled =
        await androidImplementation
            ?.areNotificationsEnabled()
            .timeout(_platformCallTimeout, onTimeout: () => false) ??
        true;
    final exactAlarmsEnabled =
        await androidImplementation
            ?.canScheduleExactNotifications()
            .timeout(_platformCallTimeout, onTimeout: () => false) ??
        true;
    final pendingRequests = await _notificationsPlugin
        .pendingNotificationRequests()
        .timeout(_platformCallTimeout, onTimeout: () => []);

    return NotificationHealth(
      notificationsEnabled: notificationsEnabled,
      exactAlarmsEnabled: exactAlarmsEnabled,
      pendingNotifications: pendingRequests.length,
      timezoneName: tz.local.name,
    );
  }

  static Future<void> showTestNotification() async {
    await init();
    final granted = await requestPermissions();
    if (!granted) return;

    await showNotification(
      id: 9001,
      title: 'RiseUp is awake 🌸❤️',
      body: 'Notifications are working on this build! 💕',
      payload: homePayload,
    );
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    required int id,
    String payload = homePayload,
  }) async {
    await _notificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _notificationDetails(
        channelId: _companionChannelId,
        channelName: 'RiseUp Companion',
        channelDescription: 'Supportive check-ins from RiseUp',
      ),
      payload: payload,
    );
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required int id,
    required DateTime scheduledTime,
    String payload = companionPayload,
  }) async {
    await _scheduleAt(
      id: id,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      payload: payload,
      channelId: _companionChannelId,
      channelName: 'RiseUp Companion',
      channelDescription: 'Supportive check-ins from RiseUp',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleCompanionCheckIns({
    CompanionMode mode = CompanionMode.balanced,
    int daysAhead = 7,
  }) async {
    // Disabled as per user request to only have Todo and Habit tracker reminders
    await cancelCompanionCheckIns();
  }

  static Future<void> scheduleReflectionReminder({
    int hour = 21,
    int minute = 30,
  }) async {
    final scheduledTime = _nextTime(hour: hour, minute: minute);
    await _scheduleAt(
      id: _reflectionNotificationId,
      title: 'A Moment of Peace 🌸❤️',
      body: 'What was today\'s small win? Even the smallest step is a victory. Rest well. 💕',
      scheduledTime: scheduledTime,
      payload: reflectionPayload,
      channelId: _reflectionChannelId,
      channelName: 'RiseUp Reflection',
      channelDescription: 'Daily reflection reminders from RiseUp',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleWeeklyReview({
    int hour = 18,
    int minute = 0,
  }) async {
    final scheduledTime = _nextWeekdayTime(
      weekday: DateTime.sunday,
      hour: hour,
      minute: minute,
    );

    await _scheduleAt(
      id: _weeklyReviewNotificationId,
      title: 'Your Weekly Journey 🌹',
      body: 'Let\'s look back at your beautiful efforts this week. You did so well. 💖',
      scheduledTime: scheduledTime,
      payload: weeklyReviewPayload,
      channelId: _reflectionChannelId,
      channelName: 'RiseUp Reflection',
      channelDescription: 'Weekly review reminders from RiseUp',
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static Future<void> scheduleHabitTrackerReminder() async {
    final scheduledTime = _nextTime(hour: 22, minute: 0);
    
    final titles = [
      'Daily Habit check-in 🌺',
      'Reflect on your promises 💕',
      'A moment for your habits ❤️',
    ];
    final bodies = [
      'Consistency is a love letter to your future self. Let\'s mark today\'s habits. 🌸',
      'Hey! Before you sleep, let\'s celebrate the promises you kept today. 💖',
      'Take a gentle moment to record your habits. You are doing great! 💕',
    ];
    
    final random = math.Random();
    final title = titles[random.nextInt(titles.length)];
    final body = bodies[random.nextInt(bodies.length)];

    await _scheduleAt(
      id: _moodReminderNotificationId,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      payload: 'habit-tracker',
      channelId: _reflectionChannelId,
      channelName: 'RiseUp Reflection',
      channelDescription: 'Habit tracker reminders from RiseUp',
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleTodoNotification(Todo todo) async {
    if (todo.dueTime == null) return;
    final scheduledTime = todo.dueTime!;
    if (scheduledTime.isBefore(DateTime.now())) return;

    final lovingTitles = [
      'Time for "${todo.title}" ❤️',
      'You\'ve got this! 💖',
      'Gentle reminder 🌸',
      'A moment for you 🌹',
    ];
    final lovingBodies = [
      'Taking one small step is a beautiful act of self-care. Let\'s do this together. 💕',
      'Remember to breathe and take it easy. You are doing amazing. 🌷',
      'Your time for "${todo.title}" is here. Take a moment, and step forward with love. 🌺',
      'Every small action counts. I\'m right here cheering for you! ❤️',
    ];
    
    final index = todo.id % lovingTitles.length;
    final title = lovingTitles[index];
    final body = lovingBodies[index];

    await _scheduleAt(
      id: todo.id,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      payload: homePayload,
      channelId: _companionChannelId,
      channelName: 'RiseUp Companion',
      channelDescription: 'Supportive check-ins from RiseUp',
    );
  }

  static Future<void> cancelTodoNotification(int todoId) async {
    await _notificationsPlugin.cancel(id: todoId);
  }

  static Future<void> scheduleMvpNotificationPlan({
    CompanionMode mode = CompanionMode.balanced,
  }) async {
    await scheduleHabitTrackerReminder();
    await scheduleReflectionReminder();
    await scheduleWeeklyReview();
  }

  static Future<void> cancelNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  static Future<void> cancelCompanionCheckIns() async {
    for (
      var id = _companionNotificationStartId;
      id <= _companionNotificationEndId;
      id++
    ) {
      await _notificationsPlugin.cancel(id: id);
    }
  }

  static Future<void> updateCompanionMode(CompanionMode mode) async {
    await scheduleCompanionCheckIns(mode: mode);
  }

  static String generateContextualMessage(DateTime dateTime) {
    final hour = dateTime.hour;
    final isCollegeDay = dateTime.weekday >= DateTime.monday &&
        dateTime.weekday <= DateTime.friday;

    if (hour < 8) {
      return 'What would make today a good day?';
    }

    if (isCollegeDay && hour < 12) {
      return 'How is college going? Share a quick update.';
    }

    if (hour < 14) {
      return 'How is your energy right now?';
    }

    if (isCollegeDay && hour < 17) {
      return 'What is happening right now? A 5-second update is enough.';
    }

    if (hour < 21) {
      return 'What are you focusing on this evening?';
    }

    return 'What was today\'s small win?';
  }

  static void storePendingPayload(String? payload) {
    _pendingPayload = payload;
  }

  static void handlePendingNotificationTap() {
    final payload = _pendingPayload;
    if (payload == null) return;

    _pendingPayload = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _routeFromPayload(payload);
    });
  }

  static void handleNotificationTap(String? payload) {
    _routeFromPayload(payload ?? companionPayload);
  }

  static Future<void> _createNotificationChannels() async {
    final androidImplementation = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation == null) return;

    await androidImplementation.createNotificationChannel(
      const AndroidNotificationChannel(
        _companionChannelId,
        'RiseUp Companion',
        description: 'Supportive check-ins from RiseUp',
        importance: Importance.high,
      ),
    );

    await androidImplementation.createNotificationChannel(
      const AndroidNotificationChannel(
        _reflectionChannelId,
        'RiseUp Reflection',
        description: 'Reflection and weekly review reminders from RiseUp',
        importance: Importance.defaultImportance,
      ),
    );

    await androidImplementation.createNotificationChannel(
      const AndroidNotificationChannel(
        _achievementChannelId,
        'RiseUp Achievements',
        description: 'Celebrations for progress and consistency',
        importance: Importance.high,
      ),
    );
  }

  static NotificationDetails _notificationDetails({
    required String channelId,
    required String channelName,
    required String channelDescription,
  }) {
    final androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      icon: 'ic_notification',
      largeIcon: const DrawableResourceAndroidBitmap('ic_notification'),
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    return NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  static Future<void> _scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required String payload,
    required String channelId,
    required String channelName,
    required String channelDescription,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    final scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);

    final notificationDetails = _notificationDetails(
      channelId: channelId,
      channelName: channelName,
      channelDescription: channelDescription,
    );

    try {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload,
        matchDateTimeComponents: matchDateTimeComponents,
      );
    } catch (_) {
      await _notificationsPlugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: payload,
        matchDateTimeComponents: matchDateTimeComponents,
      );
    }
  }

  static DateTime _nextTime({required int hour, required int minute}) {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);
    if (!scheduledTime.isAfter(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }
    return scheduledTime;
  }

  static DateTime _nextWeekdayTime({
    required int weekday,
    required int hour,
    required int minute,
  }) {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);
    final daysUntilWeekday = (weekday - scheduledTime.weekday) % 7;
    scheduledTime = scheduledTime.add(Duration(days: daysUntilWeekday));

    if (!scheduledTime.isAfter(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 7));
    }

    return scheduledTime;
  }

  static String _titleForCompanionCheckIn(DateTime dateTime) {
    if (dateTime.hour < 12) return 'Morning check-in';
    if (dateTime.hour < 17) return 'Quick companion check-in';
    if (dateTime.hour < 21) return 'Evening focus check-in';
    return 'Night reflection check-in';
  }

  static void _handleNotificationResponse(NotificationResponse response) {
    handleNotificationTap(response.payload);
  }

  static Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();

    try {
      final localTimezone = await FlutterTimezone.getLocalTimezone()
          .timeout(_platformCallTimeout);
      tz.setLocalLocation(tz.getLocation(localTimezone.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    }
  }

  static void _routeFromPayload(String payload) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      _pendingPayload = payload;
      return;
    }

    switch (payload) {
      case companionPayload:
        context.push('/quick-update');
        break;
      case reflectionPayload:
        context.push('/journal');
        break;
      case weeklyReviewPayload:
        context.push('/progress');
        break;
      case moodPayload:
        context.push('/check-in');
        break;
      case 'habit-tracker':
        context.push('/habit-tracker');
        break;
      default:
        context.go('/home');
    }
  }
}
