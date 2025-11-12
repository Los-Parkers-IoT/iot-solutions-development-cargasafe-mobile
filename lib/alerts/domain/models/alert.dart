import 'incident.dart';
import 'notification.dart';

class Alert {
  final int id;
  final String alertType;
  final String alertStatus; // "OPEN", "ACKNOWLEDGED", "CLOSED"
  final String description;
  final DateTime createdAt;
  final DateTime? closedAt;
  final List<Incident> incidents;
  final List<Notification> notifications;
  final int? deliveryOrderId;
  final bool viewed;

  Alert({
    required this.id,
    required this.alertType,
    required this.alertStatus,
    required this.description,
    required this.createdAt,
    this.closedAt,
    this.incidents = const [],
    this.notifications = const [],
    this.deliveryOrderId,
    this.viewed = false,
  });

  Alert copyWith({
    String? alertStatus,
    bool? viewed,
  }) {
    return Alert(
      id: id,
      alertType: alertType,
      alertStatus: alertStatus ?? this.alertStatus,
      description: description,
      createdAt: createdAt,
      closedAt: closedAt,
      incidents: incidents,
      notifications: notifications,
      deliveryOrderId: deliveryOrderId,
      viewed: viewed ?? this.viewed,
    );
  }
}
