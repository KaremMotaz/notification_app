import 'package:json_annotation/json_annotation.dart';

part 'push_notification_request_body.g.dart';

@JsonSerializable()
class PushNotificationRequestBody {
  final Message message;

  PushNotificationRequestBody({required this.message});

  factory PushNotificationRequestBody.fromJson(Map<String, dynamic> json) {
    return _$PushNotificationRequestBodyFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PushNotificationRequestBodyToJson(this);
  }
}

@JsonSerializable()
class Message {
  final String token;
  final NotificationData notification;

  Message({required this.token, required this.notification});

  factory Message.fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MessageToJson(this);
  }
}

@JsonSerializable()
class NotificationData {
  final String title;
  final String body;

  NotificationData({required this.title, required this.body});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return _$NotificationDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NotificationDataToJson(this);
  }
}
