import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:notification_app/core/services/push_notifications_service.dart';
import 'package:notification_app/features/push_notification/data/models/push_notification_request_body.dart';
import 'package:notification_app/features/push_notification/data/repos/api_notification_repo.dart';
import 'package:notification_app/core/errors/auth_failure.dart';
import 'package:notification_app/core/errors/failure.dart';
import 'package:notification_app/core/errors/server_failure.dart';
import 'package:notification_app/core/services/api_notification_service.dart';

class ApiNotificationRepoImp extends ApiNotificationRepo {
  String? _cachedToken;
  DateTime? _expiry;
  final ApiNotificationService apiNotificationService;

  ApiNotificationRepoImp({required this.apiNotificationService});
  Future<String> getAccessToken() async {
    if (_cachedToken != null &&
        _expiry != null &&
        DateTime.now().isBefore(_expiry!)) {
      return _cachedToken!;
    }

    final clientEmail = dotenv.env['CLIENT_EMAIL']!;
    final privateKey = dotenv.env['PRIVATE_KEY']!;

    final accountCredentials = ServiceAccountCredentials(
      clientEmail,
      ClientId(clientEmail, null),
      privateKey,
    );

    const scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
    final client = await clientViaServiceAccount(accountCredentials, scopes);

    final accessToken = client.credentials.accessToken;
    client.close();

    _cachedToken = accessToken.data;
    _expiry = accessToken.expiry;

    return _cachedToken!;
  }

  @override
  Future<Either<Failure, Unit>> pushNotification({
    required NotificationData notificationData,
  }) async {
    try {
      final String accessToken = await getAccessToken();
      final String deviceToken =
          await PushNotificationsService.getDeviceToken();
      await apiNotificationService.pushNotification(
        authorization: "Bearer $accessToken",
        body: PushNotificationRequestBody(
          message: Message(token: deviceToken, notification: notificationData),
        ),
      );
      return right(unit);
    } on ServerFailure catch (e) {
      log(e.toString());
      return left(e);
    } catch (e) {
      log(e.toString());
      return left(
        AuthFailure(message: "Something went wrong. Please try again."),
      );
    }
  }
}
