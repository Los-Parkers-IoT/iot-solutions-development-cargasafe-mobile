class FleetEndpoints {
  FleetEndpoints(this.base);
  final String base; // ej: http://localhost:8080/api/v1

  // Devices
  String get devices => '$base/fleet/devices';
  String deviceById(int id) => '$base/fleet/devices/$id';
  String deviceFirmware(int id) => '$base/fleet/devices/$id/firmware';
  String deviceOnline(int id) => '$base/fleet/devices/$id/online';
  String devicesByOnline(bool online) => '$base/fleet/devices/by-online/$online';
  String deviceByImei(String imei) => '$base/fleet/devices/by-imei/${Uri.encodeComponent(imei)}';

  // Vehicles
  String get vehicles => '$base/fleet/vehicles';
  String vehicleById(int id) => '$base/fleet/vehicles/$id';
  String vehicleAssign(int id, String imei) =>
      '$base/fleet/vehicles/$id/assign-device/${Uri.encodeComponent(imei)}';
  String vehicleUnassign(int id, String imei) =>
      '$base/fleet/vehicles/$id/unassign-device/${Uri.encodeComponent(imei)}';
  String vehicleStatus(int id) => '$base/fleet/vehicles/$id/status';
  String vehiclesByType(String type) => '$base/fleet/vehicles/by-type/${Uri.encodeComponent(type)}';
  String vehiclesByStatus(String status) => '$base/fleet/vehicles/by-status/${Uri.encodeComponent(status)}';
  String vehicleByPlate(String plate) => '$base/fleet/vehicles/by-plate/${Uri.encodeComponent(plate)}';
}
