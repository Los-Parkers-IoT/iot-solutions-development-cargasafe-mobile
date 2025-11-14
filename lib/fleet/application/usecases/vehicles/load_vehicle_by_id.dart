import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class LoadVehicleById {
  LoadVehicleById(this.repo);
  final VehicleRepository repo;

  Future<Result<Vehicle>> call(int id) => repo.getById(id);
}
