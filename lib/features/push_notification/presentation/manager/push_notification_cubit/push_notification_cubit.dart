import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_app/core/errors/failure.dart';
import 'package:notification_app/features/push_notification/data/models/push_notification_request_body.dart';
import 'package:notification_app/features/push_notification/data/repos/api_notification_repo_imp.dart';
part 'push_notification_state.dart';

class PushNotificationCubit extends Cubit<PushNotificationState> {
  final ApiNotificationRepoImp apiNotificationRepoImp;

  PushNotificationCubit({required this.apiNotificationRepoImp})
    : super(PushNotificationInitialState());

  Future<void> pushNotification({
    required NotificationData notificationData,
  }) async {
    emit(PushNotificationLoadingState());

    final Either<Failure, Unit> result = await apiNotificationRepoImp
        .pushNotification(notificationData: notificationData);

    result.fold(
      (failure) {
        emit(PushNotificationFailureState(message: failure.message));
      },
      (unit) {
        emit(PushNotificationSuccessState());
      },
    );
  }
}
