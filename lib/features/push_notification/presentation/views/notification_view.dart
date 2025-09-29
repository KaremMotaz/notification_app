import 'dart:developer';
import 'package:flutter/material.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: PushNotificationForm(),
          ),
        ),
      ),
    );
  }
}
