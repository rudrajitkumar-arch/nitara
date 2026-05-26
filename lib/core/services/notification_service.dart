import 'package:flutter/material.dart' show Color;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
    );
  }

  // ─── Immediate notification ────────────────────────────────────────────────
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'nitara_general',
          'Nitara Notifications',
          channelDescription: 'General Nitara app notifications',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFFE91E8C),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  // ─── Scheduled notification ────────────────────────────────────────────────
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    RepeatInterval? repeat,
  }) async {
    final scheduledTz = tz.TZDateTime.from(scheduledDate, tz.local);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTz,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'nitara_reminders',
          'Nitara Reminders',
          channelDescription: 'Scheduled reminders from Nitara',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFFE91E8C),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: repeat == RepeatInterval.daily
          ? DateTimeComponents.time
          : repeat == RepeatInterval.weekly
              ? DateTimeComponents.dayOfWeekAndTime
              : null,
    );
  }

  // ─── Daily wellness reminder ───────────────────────────────────────────────
  Future<void> scheduleDailyWellnessReminder() async {
    final now = DateTime.now();
    var scheduled = DateTime(now.year, now.month, now.day, 9, 0);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    await scheduleNotification(
      id: 1001,
      title: '🌸 Good Morning, Mama!',
      body: 'Time for your daily wellness check-in. How are you feeling today?',
      scheduledDate: scheduled,
      repeat: RepeatInterval.daily,
    );
  }

  // ─── Water reminder ────────────────────────────────────────────────────────
  Future<void> scheduleWaterReminders() async {
    final hours = [9, 11, 13, 15, 17, 19, 21];
    for (var i = 0; i < hours.length; i++) {
      final now = DateTime.now();
      var scheduled = DateTime(now.year, now.month, now.day, hours[i], 0);
      if (scheduled.isBefore(now)) {
        scheduled = scheduled.add(const Duration(days: 1));
      }
      await scheduleNotification(
        id: 2000 + i,
        title: '💧 Hydration Time!',
        body: 'Drink a glass of water for you and your baby 💕',
        scheduledDate: scheduled,
        repeat: RepeatInterval.daily,
      );
    }
  }

  // ─── Cancel notification ───────────────────────────────────────────────────
  Future<void> cancelNotification(int id) => _plugin.cancel(id);

  Future<void> cancelAll() => _plugin.cancelAll();
}
