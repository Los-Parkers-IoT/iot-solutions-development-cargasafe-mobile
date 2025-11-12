import '../../../../shared/core/result.dart';
import '../../../domain/entities/device.dart';
import '../../../domain/repositories/device_repository.dart';

class LoadDevices {
  LoadDevices(this.repo);
  final DeviceRepository repo;

  Future<Result<List<Device>>> call() => repo.getAll();
}
