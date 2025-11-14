import '../../../../shared/core/result.dart';
import '../../../domain/repositories/device_repository.dart';

class DeleteDevice {
  DeleteDevice(this.repo);
  final DeviceRepository repo;

  Future<Result<void>> call(int id) => repo.delete(id);
}
