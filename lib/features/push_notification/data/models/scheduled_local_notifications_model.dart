class ScheduledLocalNotificationsModel {
  final int id;
  final String title;
  final String body;
  final Duration scheduledDuration;
  final String payload;

  const ScheduledLocalNotificationsModel({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledDuration,
    this.payload = 'schedule notification',
  });
}
