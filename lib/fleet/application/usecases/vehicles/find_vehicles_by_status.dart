import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/entities/vehicle_status.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class FindVehiclesByStatus {
  FindVehiclesByStatus(this.repo);
  final VehicleRepository repo;

  Future<Result<List<Vehicle>>> call(VehicleStatus status) =>
      repo.findByStatus(status);
}
