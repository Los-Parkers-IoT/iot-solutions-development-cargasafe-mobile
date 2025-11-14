import 'vehicle_type.dart';
import 'vehicle_status.dart';

class Vehicle {
  final int? id;
  final String plate;
  final VehicleType type;
  final List<String> capabilities; // UPPER_CASE
  final VehicleStatus status;
  final num odometerKm;
  final List<String> deviceImeis;

  const Vehicle({
    this.id,
    required this.plate,
    required this.type,
    required this.capabilities,
    required this.status,
    required this.odometerKm,
    required this.deviceImeis,
  });

  Vehicle copyWith({
    int? id,
    String? plate,
    VehicleType? type,
    List<String>? capabilities,
    VehicleStatus? status,
    num? odometerKm,
    List<String>? deviceImeis,
  }) => Vehicle(
    id: id ?? this.id,
    plate: plate ?? this.plate,
    type: type ?? this.type,
    capabilities: capabilities ?? this.capabilities,
    status: status ?? this.status,
    odometerKm: odometerKm ?? this.odometerKm,
    deviceImeis: deviceImeis ?? this.deviceImeis,
  );

  static const defaultVehicle = Vehicle(
    plate: '',
    type: VehicleType.TRUCK,
    capabilities: <String>[],
    status: VehicleStatus.IN_SERVICE,
    odometerKm: 0,
    deviceImeis: <String>[],
  );
}
