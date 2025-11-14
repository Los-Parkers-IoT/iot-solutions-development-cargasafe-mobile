class Device {
  final int? id;
  final String imei;
  final String firmware;
  final bool online;
  final String? vehiclePlate;

  const Device({
    this.id,
    required this.imei,
    required this.firmware,
    required this.online,
    this.vehiclePlate,
  });

  Device copyWith({
    int? id,
    String? imei,
    String? firmware,
    bool? online,
    String? vehiclePlate,
  }) => Device(
    id: id ?? this.id,
    imei: imei ?? this.imei,
    firmware: firmware ?? this.firmware,
    online: online ?? this.online,
    vehiclePlate: vehiclePlate ?? this.vehiclePlate,
  );

  static const defaultDevice = Device(
    imei: '',
    firmware: 'v1.0.0',
    online: false,
    vehiclePlate: null,
  );
}
