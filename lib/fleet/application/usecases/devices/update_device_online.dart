import '../../../../shared/core/result.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

class UpdateDeviceOnline {
  UpdateDeviceOnline(this.repo);
  final DeviceRepository repo;

  Future<Result<Device>> call(int id, bool online) =>
      repo.updateOnline(id, online);
}
