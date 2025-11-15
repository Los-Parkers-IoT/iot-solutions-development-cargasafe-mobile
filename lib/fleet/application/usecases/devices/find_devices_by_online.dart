import '../../../../shared/core/result.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

class FindDevicesByOnline {
  FindDevicesByOnline(this.repo);
  final DeviceRepository repo;

  Future<Result<List<Device>>> call(bool online) =>
      repo.findByOnline(online);
}
