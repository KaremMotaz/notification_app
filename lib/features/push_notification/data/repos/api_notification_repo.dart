import 'package:dartz/dartz.dart';
import 'package:notification_app/features/push_notification/data/models/push_notification_request_body.dart';
import 'package:notification_app/core/errors/failure.dart';

abstract class ApiNotificationRepo {
  Future<Either<Failure, Unit>> pushNotification({
    required NotificationData notificationData,
  });
}
