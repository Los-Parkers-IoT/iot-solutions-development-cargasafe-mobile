import '../../../../shared/core/result.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class UnassignDeviceFromVehicle {
  UnassignDeviceFromVehicle(this.repo);
  final VehicleRepository repo;

  Future<Result<void>> call(int vehicleId, String imei) =>
      repo.unassignDevice(vehicleId, imei);
}
