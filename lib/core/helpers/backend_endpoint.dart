import 'package:flutter_dotenv/flutter_dotenv.dart';

class BackendEndpoint {
  static const notificationBaseUrl = "https://fcm.googleapis.com/";
  static final accessToken = dotenv.env['ACCESS_TOKEN'] ?? '';
  static const projectID = "notification-app-27554";
  static const pushNotification = "v1/projects/$projectID/messages:send";
}
