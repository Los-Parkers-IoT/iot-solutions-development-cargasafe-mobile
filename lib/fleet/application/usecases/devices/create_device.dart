import '../../../../shared/core/result.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

class CreateDevice {
  CreateDevice(this.repo);
  final DeviceRepository repo;

  Future<Result<Device>> call(Device payload) => repo.create(payload);
}
