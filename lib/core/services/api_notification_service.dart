import 'package:dio/dio.dart';
import 'package:notification_app/core/helpers/backend_endpoint.dart';
import 'package:notification_app/features/push_notification/data/models/push_notification_request_body.dart';
import 'package:retrofit/retrofit.dart';
part 'api_notification_service.g.dart';

@RestApi(baseUrl: BackendEndpoint.notificationBaseUrl)
abstract class ApiNotificationService {
  factory ApiNotificationService(Dio dio) = _ApiNotificationService;

  @POST(BackendEndpoint.pushNotification)
  Future<void> pushNotification({
    @Header("Authorization") required String authorization,
    @Body() required PushNotificationRequestBody body,
  });
}
