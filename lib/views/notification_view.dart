import 'package:flutter/material.dart';
import 'package:notification_app/models/local_notifications_model.dart';
import 'package:notification_app/models/scheduled_local_notifications_model.dart';
import 'package:notification_app/services/local_notification_service.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text("Push Notification"),
        centerTitle: true,
        leading: Icon(Icons.notifications, color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.black),
              title: const Text("Push Notification Basic"),
              trailing: IconButton(
                icon: Icon(Icons.cancel, color: Colors.red),
                onPressed: () {
                  LocalNotificationService.cancelNotification(0);
                },
              ),
              onTap: () {
                LocalNotificationService.showBasicNotification(
                  localNotificationsModel: LocalNotificationsModel(
                    id: 0,
                    title: "Basic Notification",
                    body: "Basic Notification Body",
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.black),
              title: const Text("Push Notification Repeating"),
              trailing: IconButton(
                icon: Icon(Icons.cancel, color: Colors.red),
                onPressed: () {
                  LocalNotificationService.cancelNotification(1);
                },
              ),
              onTap: () {
                LocalNotificationService.showRepeatingNotification(
                  localNotificationsModel: LocalNotificationsModel(
                    id: 1,
                    title: "Repeating Notification",
                    body: "Repeating Notification Body",
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.black),
              title: const Text("Push Notification Schedule"),
              trailing: IconButton(
                icon: Icon(Icons.cancel, color: Colors.red),
                onPressed: () {
                  LocalNotificationService.cancelNotification(2);
                },
              ),
              onTap: () {
                LocalNotificationService.showScheduleNotification(
                  scheduledLocalNotificationsModel:
                      ScheduledLocalNotificationsModel(
                        id: 2,
                        title: "Schedule Notification",
                        body: "Schedule Notification Body",
                        scheduledDuration: Duration(seconds: 5),
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
