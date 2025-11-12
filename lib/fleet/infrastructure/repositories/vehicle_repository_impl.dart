// infrastructure/repositories/vehicle_repository_impl.dart
import '../../../shared/core/result.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/entities/vehicle_status.dart';
import '../../domain/entities/vehicle_type.dart';
import '../../domain/repositories/vehicle_repository.dart';
import '../datasources/vehicle_remote_ds.dart';
import '../mappers/vehicle_mapper.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  VehicleRepositoryImpl(this.ds);
  final VehicleRemoteDataSource ds;

  @override
  Future<Result<List<Vehicle>>> getAll() async {
    try { return Ok(await ds.getAll()); }
    catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<Vehicle>> getById(int id) async {
    try { return Ok(await ds.getById(id)); }
    catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<Vehicle>> create(Vehicle payload) async {
    try { return Ok(await ds.create(payload)); }
    catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<Vehicle>> update(Vehicle payload) async {
    try { return Ok(await ds.update(payload)); }
    catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<void>> delete(int id) async {
    try { await ds.delete(id); return Ok(null); }
    catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<Vehicle>> updateStatus(int id, VehicleStatus status) async {
    try {
      final v = await ds.updateStatus(id, U(status.name));
      return Ok(v);
    } catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<List<Vehicle>>> findByType(VehicleType type) async {
    try {
      final list = await ds.findByType(U(type.name));
      return Ok(list);
    } catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<List<Vehicle>>> findByStatus(VehicleStatus status) async {
    try {
      final list = await ds.findByStatus(U(status.name));
      return Ok(list);
    } catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<Vehicle>> findByPlate(String plate) async {
    try { return Ok(await ds.findByPlate(plate)); }
    catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<Vehicle>> assignDevice(int vehicleId, String imei) async {
    try { return Ok(await ds.assignDevice(vehicleId, imei)); }
    catch (e) { return Err(Exception(e.toString())); }
  }

  @override
  Future<Result<void>> unassignDevice(int vehicleId, String imei) async {
    try { await ds.unassignDevice(vehicleId, imei); return Ok(null); }
    catch (e) { return Err(Exception(e.toString())); }
  }
}
