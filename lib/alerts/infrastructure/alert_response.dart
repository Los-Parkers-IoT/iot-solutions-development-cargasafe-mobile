class IncidentResource {
  final int id;
  final int alertId;
  final String description;
  final DateTime createdAt;
  final DateTime? acknowledgedAt;
  final DateTime? closedAt;

  IncidentResource({
    required this.id,
    required this.alertId,
    required this.description,
    required this.createdAt,
    this.acknowledgedAt,
    this.closedAt,
  });

  factory IncidentResource.fromJson(Map<String, dynamic> json) {
    return IncidentResource(
      id: json['id'] ?? 0,
      alertId: json['alertId'] ?? 0,
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      acknowledgedAt: json['acknowledgedAt'] != null
          ? DateTime.parse(json['acknowledgedAt'])
          : null,
      closedAt:
      json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alertId': alertId,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'acknowledgedAt': acknowledgedAt?.toIso8601String(),
      'closedAt': closedAt?.toIso8601String(),
    };
  }
}

class NotificationResource {
  final int id;
  final int alertId;
  final String notificationChannel;
  final String message;
  final DateTime sentAt;

  NotificationResource({
    required this.id,
    required this.alertId,
    required this.notificationChannel,
    required this.message,
    required this.sentAt,
  });

  factory NotificationResource.fromJson(Map<String, dynamic> json) {
    return NotificationResource(
      id: json['id'] ?? 0,
      alertId: json['alertId'] ?? 0,
      notificationChannel: json['notificationChannel'] ?? '',
      message: json['message'] ?? '',
      sentAt: DateTime.parse(json['sentAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alertId': alertId,
      'notificationChannel': notificationChannel,
      'message': message,
      'sentAt': sentAt.toIso8601String(),
    };
  }
}

class AlertResource {
  final int id;
  final String alertType;
  final String alertStatus; // OPEN | ACKNOWLEDGED | CLOSED
  final DateTime createdAt;
  final DateTime? closedAt;
  final String description;
  final List<IncidentResource>? incidents;
  final List<NotificationResource>? notifications;

  AlertResource({
    required this.id,
    required this.alertType,
    required this.alertStatus,
    required this.createdAt,
    this.closedAt,
    required this.description,
    this.incidents,
    this.notifications,
  });

  factory AlertResource.fromJson(Map<String, dynamic> json) {
    return AlertResource(
      id: json['id'] ?? 0,
      alertType: json['alertType'] ?? '',
      alertStatus: json['alertStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      closedAt:
      json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
      description: json['description'] ?? '',
      incidents: json['incidents'] != null
          ? (json['incidents'] as List)
          .map((i) => IncidentResource.fromJson(i))
          .toList()
          : null,
      notifications: json['notifications'] != null
          ? (json['notifications'] as List)
          .map((n) => NotificationResource.fromJson(n))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alertType': alertType,
      'alertStatus': alertStatus,
      'createdAt': createdAt.toIso8601String(),
      'closedAt': closedAt?.toIso8601String(),
      'description': description,
      'incidents': incidents?.map((i) => i.toJson()).toList(),
      'notifications': notifications?.map((n) => n.toJson()).toList(),
    };
  }
}

class AlertResponse {
  final List<AlertResource> alerts;

  AlertResponse({required this.alerts});

  factory AlertResponse.fromJson(Map<String, dynamic> json) {
    return AlertResponse(
      alerts: (json['alerts'] as List)
          .map((a) => AlertResource.fromJson(a))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alerts': alerts.map((a) => a.toJson()).toList(),
    };
  }
}
