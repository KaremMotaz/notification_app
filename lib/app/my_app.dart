import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_app/core/services/api_notification_service.dart';
import 'package:notification_app/features/push_notification/data/repos/api_notification_repo_imp.dart';
import 'package:notification_app/features/push_notification/presentation/manager/push_notification_cubit/push_notification_cubit.dart';
import 'package:notification_app/features/push_notification/presentation/views/notification_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PushNotificationCubit(
          apiNotificationRepoImp: ApiNotificationRepoImp(
            apiNotificationService: ApiNotificationService(Dio()),
          ),
        ),
        child: NotificationView(),
      ),
    );
  }
}
