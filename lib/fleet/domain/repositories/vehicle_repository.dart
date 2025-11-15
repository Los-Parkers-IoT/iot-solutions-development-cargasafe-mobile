import '../../../shared/core/result.dart';
import '../entities/vehicle.dart';
import '../entities/vehicle_status.dart';
import '../entities/vehicle_type.dart';

abstract class VehicleRepository {
  Future<Result<List<Vehicle>>> getAll();
  Future<Result<Vehicle>> getById(int id);
  Future<Result<Vehicle>> create(Vehicle payload);
  Future<Result<Vehicle>> update(Vehicle payload);
  Future<Result<void>>    delete(int id);

  Future<Result<Vehicle>> updateStatus(int id, VehicleStatus status);
  Future<Result<List<Vehicle>>> findByType(VehicleType type);
  Future<Result<List<Vehicle>>> findByStatus(VehicleStatus status);
  Future<Result<Vehicle>> findByPlate(String plate);
  Future<Result<Vehicle>> assignDevice(int vehicleId, String imei);
  Future<Result<void>>    unassignDevice(int vehicleId, String imei);
}
