// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationRequestBody _$PushNotificationRequestBodyFromJson(
  Map<String, dynamic> json,
) => PushNotificationRequestBody(
  message: Message.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PushNotificationRequestBodyToJson(
  PushNotificationRequestBody instance,
) => <String, dynamic>{'message': instance.message};

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  token: json['token'] as String,
  notification: NotificationData.fromJson(
    json['notification'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'token': instance.token,
  'notification': instance.notification,
};

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{'title': instance.title, 'body': instance.body};
