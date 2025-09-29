part of 'push_notification_cubit.dart';

@immutable
sealed class PushNotificationState {}

final class PushNotificationInitialState extends PushNotificationState {}

final class PushNotificationLoadingState extends PushNotificationState {}

final class PushNotificationSuccessState extends PushNotificationState {}

final class PushNotificationFailureState extends PushNotificationState {
  final String message;
  PushNotificationFailureState({required this.message});
}
