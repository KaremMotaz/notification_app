class LocalNotificationsModel {
  final int id;
  final String title;
  final String body;
  final String payload;

  const LocalNotificationsModel({
    required this.id,
    required this.title,
    required this.body,
    this.payload = 'basic notification',
  });
}
