class Notification {
  final int id;
  final int alertId;
  final String notificationChannel;
  final String message;
  final DateTime sentAt;

  Notification({
    required this.id,
    required this.alertId,
    required this.notificationChannel,
    required this.message,
    required this.sentAt,
  });
}
