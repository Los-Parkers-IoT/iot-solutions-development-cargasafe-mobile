// infrastructure/mappers/vehicle_mapper.dart
import '../../domain/entities/vehicle.dart';
import '../../domain/entities/vehicle_type.dart';
import '../../domain/entities/vehicle_status.dart';
import '../dto/vehicle_dto.dart';

String U(Object? s) => (s ?? '').toString().trim().toUpperCase();
List<String> UA(Iterable? xs, {List<String> fallback = const []}) =>
    (xs == null ? fallback : xs.whereType<Object>())
        .map((e) => U(e))
        .toList();

Vehicle toVehicle(VehicleDto dto) => Vehicle(
  id: dto.id,
  plate: dto.plate.trim(),
  type: parseVehicleType(dto.type),
  capabilities: (dto.capabilities ?? const <String>[]),
  status: parseVehicleStatus(dto.status),
  odometerKm: dto.odometerKm,
  deviceImeis: (dto.deviceImeis ?? const <String>[]),
);

/// Frontend -> Backend (forzar UPPER_CASE en type/status/capabilities)
Map<String, dynamic> fromVehicleCreate(Vehicle m) => {
  'plate': m.plate.trim(),
  'type': U(m.type.name),
  'capabilities': UA(m.capabilities),
  'status': U(m.status.name),
  'odometerKm': m.odometerKm,
  'deviceImeis': List<String>.from(m.deviceImeis),
};

Map<String, dynamic> fromVehicleUpdate(Vehicle m) => fromVehicleCreate(m);
