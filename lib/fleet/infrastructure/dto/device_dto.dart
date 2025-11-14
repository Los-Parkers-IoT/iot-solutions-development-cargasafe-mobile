class DeviceDto {
  final int id;
  final String imei;
  final String firmware;
  final bool online;
  final String? vehiclePlate;
  DeviceDto({required this.id, required this.imei, required this.firmware, required this.online, this.vehiclePlate});
  factory DeviceDto.fromJson(Map<String, dynamic> j) => DeviceDto(
    id: j['id'] as int,
    imei: (j['imei'] ?? '').toString().trim(),
    firmware: (j['firmware'] ?? 'v1.0.0').toString(),
    online: (j['online'] ?? false) as bool,
    vehiclePlate: j['vehiclePlate'] as String?,
  );
  Map<String, dynamic> toJson() => {
    'id': id, 'imei': imei, 'firmware': firmware, 'online': online, 'vehiclePlate': vehiclePlate
  };
}
