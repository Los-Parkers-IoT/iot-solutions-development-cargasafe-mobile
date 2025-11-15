import '../../../shared/core/result.dart';
import '../entities/device.dart';

abstract class DeviceRepository {
  Future<Result<List<Device>>> getAll();
  Future<Result<Device>> getById(int id);
  Future<Result<Device>> create(Device payload);
  Future<Result<Device>> update(Device payload);
  Future<Result<void>>   delete(int id);

  Future<Result<Device>> updateFirmware(int id, String firmware);
  Future<Result<Device>> updateOnline(int id, bool online);
  Future<Result<List<Device>>> findByOnline(bool online);
  Future<Result<Device>> findByImei(String imei);
}
