import 'package:flutter/foundation.dart';

import '../../domain/entities/device.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/entities/vehicle_status.dart';
import '../../domain/entities/vehicle_type.dart';
import '../../application/usecases/devices/create_device.dart';
import '../../application/usecases/devices/delete_device.dart';
import '../../application/usecases/devices/find_device_by_imei.dart';
import '../../application/usecases/devices/find_devices_by_online.dart';
import '../../application/usecases/devices/load_device_by_id.dart';
import '../../application/usecases/devices/load_devices.dart';
import '../../application/usecases/devices/update_device.dart';
import '../../application/usecases/devices/update_device_firmware.dart';
import '../../application/usecases/devices/update_device_online.dart';

import '../../application/usecases/vehicles/assign_device_to_vehicle.dart';
import '../../application/usecases/vehicles/create_vehicle.dart';
import '../../application/usecases/vehicles/delete_vehicle.dart';
import '../../application/usecases/vehicles/find_vehicle_by_plate.dart';
import '../../application/usecases/vehicles/find_vehicles_by_status.dart';
import '../../application/usecases/vehicles/find_vehicles_by_type.dart';
import '../../application/usecases/vehicles/load_vehicle_by_id.dart';
import '../../application/usecases/vehicles/load_vehicles.dart';
import '../../application/usecases/vehicles/unassign_device_from_vehicle.dart';
import '../../application/usecases/vehicles/update_vehicle.dart';
import '../../application/usecases/vehicles/update_vehicle_status.dart';

import '../../../shared/core/result.dart';

class FleetProvider extends ChangeNotifier {
  FleetProvider({
    // DEVICES
    required this.loadDevicesUC,
    required this.loadDeviceByIdUC,
    required this.createDeviceUC,
    required this.updateDeviceUC,
    required this.updateDeviceFirmwareUC,
    required this.updateDeviceOnlineUC,
    required this.deleteDeviceUC,
    required this.findDevicesByOnlineUC,
    required this.findDeviceByImeiUC,
    // VEHICLES
    required this.loadVehiclesUC,
    required this.loadVehicleByIdUC,
    required this.createVehicleUC,
    required this.updateVehicleUC,
    required this.updateVehicleStatusUC,
    required this.deleteVehicleUC,
    required this.assignDeviceUC,
    required this.unassignDeviceUC,
    required this.findVehicleByPlateUC,
    required this.findVehiclesByTypeUC,
    required this.findVehiclesByStatusUC,
  });

  // ================== Use cases (inyectados) ==================
  // DEVICES
  final LoadDevices loadDevicesUC;
  final LoadDeviceById loadDeviceByIdUC;
  final CreateDevice createDeviceUC;
  final UpdateDevice updateDeviceUC;
  final UpdateDeviceFirmware updateDeviceFirmwareUC;
  final UpdateDeviceOnline updateDeviceOnlineUC;
  final DeleteDevice deleteDeviceUC;
  final FindDevicesByOnline findDevicesByOnlineUC;
  final FindDeviceByImei findDeviceByImeiUC;

  // VEHICLES
  final LoadVehicles loadVehiclesUC;
  final LoadVehicleById loadVehicleByIdUC;
  final CreateVehicle createVehicleUC;
  final UpdateVehicle updateVehicleUC;
  final UpdateVehicleStatus updateVehicleStatusUC;
  final DeleteVehicle deleteVehicleUC;
  final AssignDeviceToVehicle assignDeviceUC;
  final UnassignDeviceFromVehicle unassignDeviceUC;
  final FindVehicleByPlate findVehicleByPlateUC;
  final FindVehiclesByType findVehiclesByTypeUC;
  final FindVehiclesByStatus findVehiclesByStatusUC;

  // ================== Estado ==================
  List<Device> _devices = [];
  List<Vehicle> _vehicles = [];
  bool _loading = false;
  String? _error;

  List<Device> get devices => _devices;
  List<Vehicle> get vehicles => _vehicles;
  bool get loading => _loading;
  String? get error => _error;

  void _spin() { _loading = true; _error = null; notifyListeners(); }
  void _stop() { _loading = false; notifyListeners(); }
  void _fail(Object e) { _error = e.toString(); _loading = false; notifyListeners(); }

  // Helper para manejar Result<T> sin dartz.fold
  T? _okOrNull<T>(Result<T> r) => r.err != null ? null : r.ok;

  // ================== DEVICES ==================
  Future<void> loadDevices() async {
    _spin();
    final res = await loadDevicesUC();
    if (res.err != null) {
      _devices = [];
      _fail(res.err!);
    } else {
      _devices = res.ok!;
      _stop();
    }
  }

  Future<Device?> loadDeviceById(int id) async {
    final res = await loadDeviceByIdUC(id);
    return _okOrNull(res);
  }

  Future<Device?> findDeviceByImei(String imei) async {
    final res = await findDeviceByImeiUC(imei);
    return _okOrNull(res);
  }

  Future<void> createDevice(Device p) async {
    _spin();
    final res = await createDeviceUC(p);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadDevices();
    }
  }

  Future<void> updateDevice(Device p) async {
    _spin();
    final res = await updateDeviceUC(p);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadDevices();
    }
  }

  Future<void> updateDeviceFirmware(int id, String firmware) async {
    _spin();
    final res = await updateDeviceFirmwareUC(id, firmware);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadDevices();
    }
  }

  Future<void> updateDeviceOnline(int id, bool online) async {
    _spin();
    final res = await updateDeviceOnlineUC(id, online);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadDevices();
    }
  }

  Future<void> deleteDevice(int id) async {
    _spin();
    final res = await deleteDeviceUC(id);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadDevices();
    }
  }

  Future<void> findDevicesByOnline(bool online) async {
    _spin();
    final res = await findDevicesByOnlineUC(online);
    if (res.err != null) {
      _devices = [];
      _fail(res.err!);
    } else {
      _devices = res.ok!;
      _stop();
    }
  }

  // ================== VEHICLES ==================
  Future<void> loadVehicles() async {
    _spin();
    final res = await loadVehiclesUC();
    if (res.err != null) {
      _vehicles = [];
      _fail(res.err!);
    } else {
      _vehicles = res.ok!;
      _stop();
    }
  }

  Future<Vehicle?> loadVehicleById(int id) async {
    final res = await loadVehicleByIdUC(id);
    return _okOrNull(res);
  }

  Future<void> createVehicle(Vehicle p) async {
    _spin();
    final res = await createVehicleUC(p);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadVehicles();
    }
  }

  Future<void> updateVehicle(Vehicle p) async {
    _spin();
    final res = await updateVehicleUC(p);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadVehicles();
    }
  }

  Future<void> deleteVehicle(int id) async {
    _spin();
    final res = await deleteVehicleUC(id);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadVehicles();
    }
  }

  Future<void> updateVehicleStatus(int id, VehicleStatus status) async {
    _spin();
    final res = await updateVehicleStatusUC(id, status);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadVehicles();
    }
  }

  Future<Vehicle?> findVehicleByPlate(String plate) async {
    final res = await findVehicleByPlateUC(plate);
    return _okOrNull(res);
  }

  Future<void> findVehiclesByType(VehicleType type) async {
    _spin();
    final res = await findVehiclesByTypeUC(type);
    if (res.err != null) {
      _vehicles = [];
      _fail(res.err!);
    } else {
      _vehicles = res.ok!;
      _stop();
    }
  }

  Future<void> findVehiclesByStatus(VehicleStatus status) async {
    _spin();
    final res = await findVehiclesByStatusUC(status);
    if (res.err != null) {
      _vehicles = [];
      _fail(res.err!);
    } else {
      _vehicles = res.ok!;
      _stop();
    }
  }

  Future<void> assignDeviceToVehicle(int vehicleId, String imei) async {
    _spin();
    final res = await assignDeviceUC(vehicleId, imei);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadVehicles();
    }
  }

  Future<void> unassignDeviceFromVehicle(int vehicleId, String imei) async {
    _spin();
    final res = await unassignDeviceUC(vehicleId, imei);
    if (res.err != null) {
      _fail(res.err!);
    } else {
      await loadVehicles();
    }
  }
}
