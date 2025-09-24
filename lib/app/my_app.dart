import 'package:flutter/material.dart';
import 'package:notification_app/views/notification_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationView(),
    );
  }
}
