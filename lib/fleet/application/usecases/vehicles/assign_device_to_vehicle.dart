import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class AssignDeviceToVehicle {
  AssignDeviceToVehicle(this.repo);
  final VehicleRepository repo;

  Future<Result<Vehicle>> call(int vehicleId, String imei) =>
      repo.assignDevice(vehicleId, imei);
}
