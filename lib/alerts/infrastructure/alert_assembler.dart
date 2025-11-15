import '../domain/models/alert.dart';
import '../domain/models/incident.dart';
import '../domain/models/notification.dart';

class AlertAssembler {
  static Alert fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] ?? 0,
      alertType: json['alertType'] ?? '',
      alertStatus: json['alertStatus'] ?? '',
      description: json['description'] ?? '',
      createdAt: _parseDate(json['createdAt']) ?? DateTime.now(),
      closedAt: _parseDate(json['closedAt']),
      incidents: (json['incidents'] as List?)
          ?.map((i) => Incident(
        id: i['id'] ?? 0,
        alertId: i['alertId'] ?? 0,
        description: i['description'] ?? '',
        createdAt: _parseDate(i['createdAt']) ?? DateTime.now(),
        acknowledgedAt: _parseDate(i['acknowledgedAt']),
        closedAt: _parseDate(i['closedAt']),
      ))
          .toList() ??
          [],
      notifications: (json['notifications'] as List?)
          ?.map((n) => Notification(
        id: n['id'] ?? 0,
        alertId: n['alertId'] ?? 0,
        notificationChannel: n['notificationChannel'] ?? '',
        message: n['message'] ?? '',
        sentAt: _parseDate(n['sentAt']) ?? DateTime.now(),
      ))
          .toList() ??
          [],
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return null;
    }
  }
}
