import '../../../../shared/core/result.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

class UpdateDeviceFirmware {
  UpdateDeviceFirmware(this.repo);
  final DeviceRepository repo;

  Future<Result<Device>> call(int id, String firmware) =>
      repo.updateFirmware(id, firmware);
}
