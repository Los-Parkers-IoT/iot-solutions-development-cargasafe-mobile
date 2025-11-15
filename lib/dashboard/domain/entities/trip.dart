import '../enums/trip_status.dart';

class Trip {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final String origin;
  final String destination;
  final String vehiclePlate;
  final String driverName;
  final String cargoType;
  final TripStatus status;
  final double distance;
  final List<String> alertIds;

  Trip({
    required this.id,
    required this.startDate,
    this.endDate,
    required this.origin,
    required this.destination,
    required this.vehiclePlate,
    required this.driverName,
    required this.cargoType,
    required this.status,
    required this.distance,
    required this.alertIds,
  });

  // Business methods
  bool get isInProgress => status == TripStatus.inProgress;
  bool get isCompleted => status == TripStatus.completed;
  bool get isCancelled => status == TripStatus.cancelled;
  bool get isDelayed => status == TripStatus.delayed;

  double getDurationInHours() {
    final end = endDate ?? DateTime.now();
    return end.difference(startDate).inHours.toDouble();
  }

  double getAverageSpeed() {
    final durationHours = getDurationInHours();
    if (durationHours == 0) return 0;
    return distance / durationHours;
  }

  Trip copyWith({
    String? id,
    DateTime? startDate,
    DateTime? endDate,
    String? origin,
    String? destination,
    String? vehiclePlate,
    String? driverName,
    String? cargoType,
    TripStatus? status,
    double? distance,
    List<String>? alertIds,
  }) {
    return Trip(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      driverName: driverName ?? this.driverName,
      cargoType: cargoType ?? this.cargoType,
      status: status ?? this.status,
      distance: distance ?? this.distance,
      alertIds: alertIds ?? this.alertIds,
    );
  }
}

