// infrastructure/datasources/vehicle_remote_ds.dart
import 'package:dio/dio.dart';
import '../../domain/entities/vehicle.dart';
import '../dto/vehicle_dto.dart';
import '../mappers/vehicle_mapper.dart';
import '../services/fleet_api_service.dart';

class VehicleRemoteDataSource {
  VehicleRemoteDataSource(this.api);
  final FleetApiService api;

  Future<List<Vehicle>> getAll() async {
    final res = await api.client.get<List>(api.ep.vehicles);
    final list = (res.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(VehicleDto.fromJson)
        .map(toVehicle)
        .toList();
    return list;
  }

  Future<Vehicle> getById(int id) async {
    final res = await api.client.get(api.ep.vehicleById(id));
    return toVehicle(VehicleDto.fromJson(res.data as Map<String, dynamic>));
  }

  Future<Vehicle> create(Vehicle payload) async {
    final res = await api.client.post(
      api.ep.vehicles,
      data: fromVehicleCreate(payload),
    );
    return toVehicle(VehicleDto.fromJson(res.data as Map<String, dynamic>));
  }

  Future<Vehicle> update(Vehicle payload) async {
    final res = await api.client.put(
      api.ep.vehicleById(payload.id!),
      data: fromVehicleUpdate(payload),
    );
    return toVehicle(VehicleDto.fromJson(res.data as Map<String, dynamic>));
  }

  Future<void> delete(int id) async {
    await api.client.delete(api.ep.vehicleById(id));
  }

  Future<Vehicle> updateStatus(int id, String statusUpper) async {
    final res = await api.client.patch(
      api.ep.vehicleStatus(id),
      data: {'status': statusUpper},
    );
    return toVehicle(VehicleDto.fromJson(res.data as Map<String, dynamic>));
  }

  Future<List<Vehicle>> findByType(String typeUpper) async {
    final res = await api.client.get<List>(api.ep.vehiclesByType(typeUpper));
    return (res.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(VehicleDto.fromJson)
        .map(toVehicle)
        .toList();
  }

  Future<List<Vehicle>> findByStatus(String statusUpper) async {
    final res = await api.client.get<List>(api.ep.vehiclesByStatus(statusUpper));
    return (res.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(VehicleDto.fromJson)
        .map(toVehicle)
        .toList();
  }

  Future<Vehicle> findByPlate(String plate) async {
    final res = await api.client.get(api.ep.vehicleByPlate(plate));
    return toVehicle(VehicleDto.fromJson(res.data as Map<String, dynamic>));
  }

  Future<Vehicle> assignDevice(int vehicleId, String imei) async {
    final res = await api.client.post(
      api.ep.vehicleAssign(vehicleId, imei),
      data: const {}, // backend no requiere body
    );
    return toVehicle(VehicleDto.fromJson(res.data as Map<String, dynamic>));
  }

  Future<void> unassignDevice(int vehicleId, String imei) async {
    await api.client.post(
      api.ep.vehicleUnassign(vehicleId, imei),
      data: const {},
    );
  }
}
