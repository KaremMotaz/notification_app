import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_app/features/push_notification/data/models/local_notifications_model.dart';
import 'package:notification_app/features/push_notification/data/models/scheduled_local_notifications_model.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  //basic Notification
  static void showBasicNotificationForPush({
    required RemoteMessage message,
  }) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 1',
      'basic notification',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('sound.wav'.split('.').first),
    );
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
      payload: "Payload Data",
    );
  }

  static void showBasicNotification({
    required LocalNotificationsModel? localNotificationsModel,
  }) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 1',
      'basic notification',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('sound.wav'.split('.').first),
    );
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
      localNotificationsModel!.id,
      localNotificationsModel.title,
      localNotificationsModel.body,
      details,
      payload: "Payload Data",
    );
  }

  static void showRepeatingNotification({
    required LocalNotificationsModel? localNotificationsModel,
  }) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 2',
      'repeating notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      localNotificationsModel!.id,
      localNotificationsModel.title,
      localNotificationsModel.body,
      RepeatInterval.everyMinute,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      details,
      payload: "Payload Data",
    );
  }

  static void showScheduleNotification({
    required ScheduledLocalNotificationsModel? scheduledLocalNotificationsModel,
  }) async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 3',
      'schedule notification',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails details = NotificationDetails(android: android);
    tz.initializeTimeZones();

    final TimezoneInfo currentTimeZone =
        await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      scheduledLocalNotificationsModel!.id,
      scheduledLocalNotificationsModel.title,
      scheduledLocalNotificationsModel.body,
      // tz.TZDateTime.now(
      //   tz.local,
      // ).add(scheduledLocalNotificationsModel.scheduledDuration),
      tz.TZDateTime(tz.local, 2025, 9, 27, 12, 12),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      details,
      payload: "Payload Data",
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> showDailySchduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'id 7',
      'daily schduled notification',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(android: android);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    var currentTime = tz.TZDateTime.now(tz.local);
    log("currentTime.year:${currentTime.year}");
    log("currentTime.month:${currentTime.month}");
    log("currentTime.day:${currentTime.day}");
    log("currentTime.hour:${currentTime.hour}");
    log("currentTime.minute:${currentTime.minute}");
    log("currentTime.second:${currentTime.second}");
    var scheduleTime = tz.TZDateTime(
      tz.local,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour,
      38,
    );
    log("scheduledTime.year:${scheduleTime.year}");
    log("scheduledTime.month:${scheduleTime.month}");
    log("scheduledTime.day:${scheduleTime.day}");
    log("scheduledTime.hour:${scheduleTime.hour}");
    log("scheduledTime.minute:${scheduleTime.minute}");
    log("scheduledTime.second:${scheduleTime.second}");
    if (scheduleTime.isBefore(currentTime)) {
      scheduleTime = scheduleTime.add(const Duration(days: 1));
      log("AfterAddedscheduledTime.year:${scheduleTime.year}");
      log("AfterAddedscheduledTime.month:${scheduleTime.month}");
      log("AfterAddedscheduledTime.day:${scheduleTime.day}");
      log("AfterAddedscheduledTime.hour:${scheduleTime.hour}");
      log("AfterAddedscheduledTime.minute:${scheduleTime.minute}");
      log("AfterAddedscheduledTime.second:${scheduleTime.second}");
      log('Added Duration to scheduled time');
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
      9,
      'Daily Schduled Notification',
      'body',
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      scheduleTime,
      details,
      payload: 'zonedSchedule5555555',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
