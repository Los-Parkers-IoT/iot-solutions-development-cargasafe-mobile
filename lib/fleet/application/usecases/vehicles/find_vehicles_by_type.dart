import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/entities/vehicle_type.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class FindVehiclesByType {
  FindVehiclesByType(this.repo);
  final VehicleRepository repo;

  Future<Result<List<Vehicle>>> call(VehicleType type) =>
      repo.findByType(type);
}
