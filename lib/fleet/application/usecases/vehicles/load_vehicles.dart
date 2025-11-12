import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class LoadVehicles {
  LoadVehicles(this.repo);
  final VehicleRepository repo;

  Future<Result<List<Vehicle>>> call() => repo.getAll();
}
