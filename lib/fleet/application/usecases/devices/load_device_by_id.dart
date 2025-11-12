import '../../../../shared/core/result.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

class LoadDeviceById {
  LoadDeviceById(this.repo);
  final DeviceRepository repo;

  Future<Result<Device>> call(int id) => repo.getById(id);
}
