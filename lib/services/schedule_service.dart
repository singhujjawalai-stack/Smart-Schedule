import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class ScheduleService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _notifications.initialize(const InitializationSettings(android: android));
  }

  Future<void> scheduleReminder(String taskId, String mode, DateTime time) async {
    const androidDetails = AndroidNotificationDetails(
      'schedule_channel',
      'Task Reminders',
      importance: Importance.high,
      priority: Priority.high,
    );
    await _notifications.zonedSchedule(
      taskId.hashCode,
      'Task Reminder',
      'Time for your scheduled task',
      tz.TZDateTime.from(time, tz.local),
      NotificationDetails(android: androidDetails),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelReminder(String taskId) async {
    await _notifications.cancel(taskId.hashCode);
  }
}
