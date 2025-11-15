import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/entities/vehicle_status.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class UpdateVehicleStatus {
  UpdateVehicleStatus(this.repo);
  final VehicleRepository repo;

  Future<Result<Vehicle>> call(int id, VehicleStatus status) =>
      repo.updateStatus(id, status);
}
