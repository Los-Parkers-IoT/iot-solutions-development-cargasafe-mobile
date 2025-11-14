import '../../../../shared/core/result.dart';
import '../../../domain/repositories/vehicle_repository.dart';

class DeleteVehicle {
  DeleteVehicle(this.repo);
  final VehicleRepository repo;

  Future<Result<void>> call(int id) => repo.delete(id);
}
