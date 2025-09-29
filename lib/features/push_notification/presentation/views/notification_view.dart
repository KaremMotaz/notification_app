import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:notification_app/features/push_notification/data/models/local_notifications_model.dart';
import 'package:notification_app/features/push_notification/data/models/scheduled_local_notifications_model.dart';
import 'package:notification_app/core/services/local_notification_service.dart';
import 'package:notification_app/features/push_notification/presentation/views/notification_details_view.dart';
import 'package:notification_app/features/push_notification/presentation/widgets/push_notification_form.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    listenToNotificationStream();
    super.initState();
  }

  void listenToNotificationStream() {
    LocalNotificationService.streamController.stream.listen((
      notificationResponse,
    ) {
      log(notificationResponse.id!.toString());
      log(notificationResponse.payload!.toString());
      //logic to get product from database.
      if (mounted != true) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              NotificationDetailsView(response: notificationResponse),
        ),
      );
    });
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PushNotificationForm(),
              ),
              SizedBox(height: 20),
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
              ElevatedButton(
                onPressed: () {
                  LocalNotificationService.cancelAllNotifications();
                },
                child: Text("Cancel All Notifications"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
