import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ================= DASHBOARD =================
import 'package:cargasafe/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:cargasafe/dashboard/application/dashboard_service.dart';
import 'package:cargasafe/dashboard/infrastructure/repositories/dashboard_repository.dart';
import 'package:cargasafe/dashboard/infrastructure/datasources/dashboard_remote_datasource.dart';

// ================= FLEET =================
import 'package:cargasafe/fleet/presentation/providers/fleet_provider.dart';
import 'package:cargasafe/fleet/infrastructure/services/fleet_api_service.dart';
import 'package:cargasafe/fleet/infrastructure/datasources/device_remote_ds.dart';
import 'package:cargasafe/fleet/infrastructure/datasources/vehicle_remote_ds.dart';
import 'package:cargasafe/fleet/infrastructure/repositories/device_repository_impl.dart';
import 'package:cargasafe/fleet/infrastructure/repositories/vehicle_repository_impl.dart';

// ================= CONFIG =================
import 'package:cargasafe/shared/core/app_config.dart';

// ================= DEVICES =================
import 'package:cargasafe/fleet/application/usecases/devices/load_devices.dart';
import 'package:cargasafe/fleet/application/usecases/devices/load_device_by_id.dart';
import 'package:cargasafe/fleet/application/usecases/devices/create_device.dart';
import 'package:cargasafe/fleet/application/usecases/devices/update_device.dart';
import 'package:cargasafe/fleet/application/usecases/devices/update_device_firmware.dart';
import 'package:cargasafe/fleet/application/usecases/devices/update_device_online.dart';
import 'package:cargasafe/fleet/application/usecases/devices/delete_device.dart';
import 'package:cargasafe/fleet/application/usecases/devices/find_devices_by_online.dart';
import 'package:cargasafe/fleet/application/usecases/devices/find_device_by_imei.dart';

// ================= VEHICLES =================
import 'package:cargasafe/fleet/application/usecases/vehicles/load_vehicles.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/load_vehicle_by_id.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/create_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/update_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/update_vehicle_status.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/delete_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/assign_device_to_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/unassign_device_from_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/find_vehicle_by_plate.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/find_vehicles_by_type.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/find_vehicles_by_status.dart';

final appProviders = <ChangeNotifierProvider>[
  // DASHBOARD
  ChangeNotifierProvider(
    create: (_) {
      final dashboardDS = DashboardRemoteDataSource();
      final dashboardRepo = DashboardRepository(remoteDataSource: dashboardDS);
      final dashboardService = DashboardService(repository: dashboardRepo);
      return DashboardProvider(service: dashboardService);
    },
  ),

  // FLEET
  ChangeNotifierProvider(
    create: (_) {
      final fleetApi = FleetApiService(baseUrl: AppConfig.baseUrl);
      final deviceDS = DeviceRemoteDataSource(fleetApi);
      final vehicleDS = VehicleRemoteDataSource(fleetApi);
      final deviceRepo = DeviceRepositoryImpl(deviceDS);
      final vehicleRepo = VehicleRepositoryImpl(vehicleDS);

      return FleetProvider(
        // DEVICES
        loadDevicesUC: LoadDevices(deviceRepo),
        loadDeviceByIdUC: LoadDeviceById(deviceRepo),
        createDeviceUC: CreateDevice(deviceRepo),
        updateDeviceUC: UpdateDevice(deviceRepo),
        updateDeviceFirmwareUC: UpdateDeviceFirmware(deviceRepo),
        updateDeviceOnlineUC: UpdateDeviceOnline(deviceRepo),
        deleteDeviceUC: DeleteDevice(deviceRepo),
        findDevicesByOnlineUC: FindDevicesByOnline(deviceRepo),
        findDeviceByImeiUC: FindDeviceByImei(deviceRepo),

        // VEHICLES
        loadVehiclesUC: LoadVehicles(vehicleRepo),
        loadVehicleByIdUC: LoadVehicleById(vehicleRepo),
        createVehicleUC: CreateVehicle(vehicleRepo),
        updateVehicleUC: UpdateVehicle(vehicleRepo),
        updateVehicleStatusUC: UpdateVehicleStatus(vehicleRepo),
        deleteVehicleUC: DeleteVehicle(vehicleRepo),
        assignDeviceUC: AssignDeviceToVehicle(vehicleRepo),
        unassignDeviceUC: UnassignDeviceFromVehicle(vehicleRepo),
        findVehicleByPlateUC: FindVehicleByPlate(vehicleRepo),
        findVehiclesByTypeUC: FindVehiclesByType(vehicleRepo),
        findVehiclesByStatusUC: FindVehiclesByStatus(vehicleRepo),
      );
    },
  ),
];
