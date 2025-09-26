import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_app/models/local_notifications_model.dart';
import 'package:notification_app/models/scheduled_local_notifications_model.dart';
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
      playSound: false,
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
      playSound: false,
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
      playSound: true,
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
    await flutterLocalNotificationsPlugin.zonedSchedule(
      scheduledLocalNotificationsModel!.id,
      scheduledLocalNotificationsModel.title,
      scheduledLocalNotificationsModel.body,
      tz.TZDateTime.now(
        tz.local,
      ).add(scheduledLocalNotificationsModel.scheduledDuration),
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
}
