// infrastructure/dto/vehicle_dto.dart
class VehicleDto {
  final int id;
  final String plate;
  final String type;               // UPPER_CASE (string)
  final List<String>? capabilities;
  final String status;             // UPPER_CASE (string)
  final num odometerKm;
  final List<String>? deviceImeis;

  VehicleDto({
    required this.id,
    required this.plate,
    required this.type,
    required this.capabilities,
    required this.status,
    required this.odometerKm,
    required this.deviceImeis,
  });

  factory VehicleDto.fromJson(Map<String, dynamic> j) => VehicleDto(
    id: (j['id'] as num).toInt(),
    plate: (j['plate'] ?? '').toString().trim(),
    type: (j['type'] ?? '').toString().trim(),
    capabilities: (j['capabilities'] as List?)
        ?.whereType<String>()
        .map((e) => e.trim())
        .toList(),
    status: (j['status'] ?? '').toString().trim(),
    odometerKm: (j['odometerKm'] as num?) ?? 0,
    deviceImeis: (j['deviceImeis'] as List?)
        ?.whereType<String>()
        .map((e) => e.trim())
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'plate': plate,
    'type': type,
    'capabilities': capabilities,
    'status': status,
    'odometerKm': odometerKm,
    'deviceImeis': deviceImeis,
  };
}
