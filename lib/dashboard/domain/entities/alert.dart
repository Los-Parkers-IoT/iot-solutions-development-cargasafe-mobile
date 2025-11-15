import '../enums/alert_type.dart';
import '../enums/alert_severity.dart';
import '../value_objects/sensor_data.dart';

class Alert {
  final String id;
  final String tripId;
  final String deviceId;
  final String vehiclePlate;
  final AlertType type;
  final AlertSeverity severity;
  final DateTime timestamp;
  final Location location;
  final SensorData sensorData;
  final bool resolved;

  Alert({
    required this.id,
    required this.tripId,
    required this.deviceId,
    required this.vehiclePlate,
    required this.type,
    required this.severity,
    required this.timestamp,
    required this.location,
    required this.sensorData,
    required this.resolved,
  });

  // Business methods
  bool get isCritical => severity == AlertSeverity.critical;
  bool get isHighPriority => severity == AlertSeverity.high || severity == AlertSeverity.critical;
  bool get isTemperatureAlert => type == AlertType.temperature;
  bool get isMovementAlert => type == AlertType.movement;

  int getAgeInMinutes() {
    return DateTime.now().difference(timestamp).inMinutes;
  }

  Alert copyWith({
    String? id,
    String? tripId,
    String? deviceId,
    String? vehiclePlate,
    AlertType? type,
    AlertSeverity? severity,
    DateTime? timestamp,
    Location? location,
    SensorData? sensorData,
    bool? resolved,
  }) {
    return Alert(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      deviceId: deviceId ?? this.deviceId,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
      location: location ?? this.location,
      sensorData: sensorData ?? this.sensorData,
      resolved: resolved ?? this.resolved,
    );
  }
}

