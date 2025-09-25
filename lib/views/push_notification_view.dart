import 'package:flutter/material.dart';

class PushNotificationView extends StatelessWidget {
  const PushNotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Push Notification")),
      body: const Center(child: Text("Push Notification")),
    );
  }
}
