import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/app/my_app.dart';
import 'package:notification_app/firebase_options.dart';
import 'package:notification_app/services/push_notifications_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'services/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  tz.initializeTimeZones();
  Future.wait([
    PushNotificationsService.init(),
    LocalNotificationService.init(),
  ]);

  runApp(const MyApp());
}
