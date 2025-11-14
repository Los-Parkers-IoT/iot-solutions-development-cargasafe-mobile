import '../../../../shared/core/result.dart';
import '../../../domain/entities/vehicle.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class FindVehicleByPlate {
  FindVehicleByPlate(this.repo);
  final VehicleRepository repo;

  Future<Result<Vehicle>> call(String plate) => repo.findByPlate(plate);
}
