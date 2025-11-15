import '../../../shared/core/result.dart';
import '../../domain/entities/device.dart';
import '../../domain/repositories/device_repository.dart';
import '../datasources/device_remote_ds.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl(this.ds);
  final DeviceRemoteDataSource ds;

  @override Future<Result<List<Device>>> getAll() async {
    try { return Ok(await ds.getAll()); } catch (e) { return Err(Exception(e.toString())); }
  }
  @override Future<Result<Device>> getById(int id) async {
    try { return Ok(await ds.getById(id)); } catch (e) { return Err(Exception(e.toString())); }
  }
  @override Future<Result<Device>> create(Device p) async {
    try { return Ok(await ds.create(p)); } catch (e) { return Err(Exception(e.toString())); }
  }
  @override Future<Result<Device>> update(Device p) async {
    try { return Ok(await ds.update(p)); } catch (e) { return Err(Exception(e.toString())); }
  }
  @override Future<Result<void>> delete(int id) async {
    try { await ds.delete(id); return Ok(null); } catch (e) { return Err(Exception(e.toString())); }
  }

  @override Future<Result<Device>> updateFirmware(int id, String f) async {
    try { return Ok(await ds.updateFirmware(id, f)); } catch (e) { return Err(Exception(e.toString())); }
  }
  @override Future<Result<Device>> updateOnline(int id, bool o) async {
    try { return Ok(await ds.updateOnline(id, o)); } catch (e) { return Err(Exception(e.toString())); }
  }
  @override Future<Result<List<Device>>> findByOnline(bool o) async {
    try { return Ok(await ds.findByOnline(o)); } catch (e) { return Err(Exception(e.toString())); }
  }
  @override Future<Result<Device>> findByImei(String imei) async {
    try { return Ok(await ds.findByImei(imei)); } catch (e) { return Err(Exception(e.toString())); }
  }
}
