import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class CreateVehicle {
  CreateVehicle(this.repo);
  final VehicleRepository repo;

  Future<Result<Vehicle>> call(Vehicle payload) => repo.create(payload);
}
