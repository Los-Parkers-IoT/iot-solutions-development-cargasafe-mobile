import '../../../../shared/core/result.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

class FindDeviceByImei {
  FindDeviceByImei(this.repo);
  final DeviceRepository repo;

  Future<Result<Device>> call(String imei) => repo.findByImei(imei);
}
