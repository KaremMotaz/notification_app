import 'package:dartz/dartz.dart';
import 'package:notification_app/features/push_notification/data/models/push_notification_request_body.dart';
import 'package:notification_app/features/push_notification/data/repos/api_notification_repo.dart';
import 'package:notification_app/core/errors/auth_failure.dart';
import 'package:notification_app/core/errors/failure.dart';
import 'package:notification_app/core/errors/server_failure.dart';
import 'package:notification_app/core/helpers/backend_endpoint.dart';
import 'package:notification_app/core/services/api_notification_service.dart';

class ApiNotificationRepoImp extends ApiNotificationRepo {
  final ApiNotificationService apiNotificationService;

  ApiNotificationRepoImp({required this.apiNotificationService});

  @override
  Future<Either<Failure, Unit>> pushNotification({
    required NotificationData notificationData,
  }) async {
    try {
      await apiNotificationService.pushNotification(
        authorization: "Bearer ${BackendEndpoint.accessToken}",
        body: PushNotificationRequestBody(
          message: Message(
            token: BackendEndpoint.deviceToken,
            notification: notificationData,
          ),
        ),
      );
      return right(unit);
    } on ServerFailure catch (e) {
      return left(e);
    } catch (e) {
      return left(
        AuthFailure(message: "Something went wrong. Please try again."),
      );
    }
  }
}
