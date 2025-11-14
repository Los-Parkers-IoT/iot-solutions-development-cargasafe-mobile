import 'package:dio/dio.dart';
import '../dto/device_dto.dart';
import '../mappers/device_mapper.dart';
import '../../domain/entities/device.dart';
import '../services/fleet_api_service.dart';

class DeviceRemoteDataSource {
  DeviceRemoteDataSource(this.api);
  final FleetApiService api;

  Future<List<Device>> getAll() async {
    final res = await api.client.get<List>(api.ep.devices);
    final list = (res.data ?? []).cast<Map<String, dynamic>>().map(DeviceDto.fromJson).map(toDevice).toList();
    return list;
  }

  Future<Device> getById(int id) async {
    final res = await api.client.get(api.ep.deviceById(id));
    return toDevice(DeviceDto.fromJson(res.data));
  }

  Future<Device> create(Device payload) async {
    final res = await api.client.post(api.ep.devices, data: fromDeviceCreate(payload));
    return toDevice(DeviceDto.fromJson(res.data));
  }

  Future<Device> update(Device payload) async {
    final res = await api.client.put(api.ep.deviceById(payload.id!), data: fromDeviceUpdate(payload));
    return toDevice(DeviceDto.fromJson(res.data));
  }

  Future<void> delete(int id) async {
    await api.client.delete(api.ep.deviceById(id));
  }

  Future<Device> updateFirmware(int id, String firmware) async {
    final res = await api.client.post(api.ep.deviceFirmware(id), data: { 'firmware': firmware });
    return toDevice(DeviceDto.fromJson(res.data));
  }

  Future<Device> updateOnline(int id, bool online) async {
    final res = await api.client.patch(api.ep.deviceOnline(id), data: { 'online': online });
    return toDevice(DeviceDto.fromJson(res.data));
  }

  Future<List<Device>> findByOnline(bool online) async {
    final res = await api.client.get<List>(api.ep.devicesByOnline(online));
    return (res.data ?? []).cast<Map<String, dynamic>>().map(DeviceDto.fromJson).map(toDevice).toList();
  }

  Future<Device> findByImei(String imei) async {
    final res = await api.client.get(api.ep.deviceByImei(imei));
    return toDevice(DeviceDto.fromJson(res.data));
  }
}
