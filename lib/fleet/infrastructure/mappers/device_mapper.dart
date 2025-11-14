import '../../domain/entities/device.dart';
import '../dto/device_dto.dart';

Device toDevice(DeviceDto d) => Device(
  id: d.id,
  imei: d.imei,
  firmware: d.firmware,
  online: d.online,
  vehiclePlate: d.vehiclePlate,
);

Map<String, dynamic> fromDeviceCreate(Device m) => {
  'imei': m.imei,
  'firmware': m.firmware,
  'online': m.online,
  'vehiclePlate': m.vehiclePlate,
};

Map<String, dynamic> fromDeviceUpdate(Device m) => fromDeviceCreate(m);
