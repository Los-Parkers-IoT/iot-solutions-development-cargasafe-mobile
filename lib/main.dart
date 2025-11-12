import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

// THEME
import 'package:cargasafe/shared/presentation/theme/app_theme.dart';
import 'package:cargasafe/shared/core/app_config.dart';

// DASHBOARD
import 'package:cargasafe/dashboard/presentation/pages/dashboard_page/dashboard_page.dart';
import 'package:cargasafe/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:cargasafe/dashboard/application/dashboard_service.dart';
import 'package:cargasafe/dashboard/infrastructure/repositories/dashboard_repository.dart';
import 'package:cargasafe/dashboard/infrastructure/datasources/dashboard_remote_datasource.dart';

// ALERTS (si aplicara en tu app)
import 'package:cargasafe/alerts/presentation/pages/alert_page/alerts_page.dart';

// FLEET (routing + DI)
import 'package:cargasafe/fleet/routing/fleet_routes.dart';
import 'package:cargasafe/fleet/infrastructure/services/fleet_api_service.dart';
import 'package:cargasafe/fleet/infrastructure/datasources/device_remote_ds.dart';
import 'package:cargasafe/fleet/infrastructure/datasources/vehicle_remote_ds.dart';
import 'package:cargasafe/fleet/infrastructure/repositories/device_repository_impl.dart';
import 'package:cargasafe/fleet/infrastructure/repositories/vehicle_repository_impl.dart';

// FLEET use cases - Devices
import 'package:cargasafe/fleet/application/usecases/devices/create_device.dart';
import 'package:cargasafe/fleet/application/usecases/devices/delete_device.dart';
import 'package:cargasafe/fleet/application/usecases/devices/find_device_by_imei.dart';
import 'package:cargasafe/fleet/application/usecases/devices/find_devices_by_online.dart';
import 'package:cargasafe/fleet/application/usecases/devices/load_device_by_id.dart';
import 'package:cargasafe/fleet/application/usecases/devices/load_devices.dart';
import 'package:cargasafe/fleet/application/usecases/devices/update_device.dart';
import 'package:cargasafe/fleet/application/usecases/devices/update_device_firmware.dart';
import 'package:cargasafe/fleet/application/usecases/devices/update_device_online.dart';

// FLEET use cases - Vehicles
import 'package:cargasafe/fleet/application/usecases/vehicles/assign_device_to_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/create_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/delete_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/find_vehicle_by_plate.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/find_vehicles_by_status.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/find_vehicles_by_type.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/load_vehicle_by_id.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/load_vehicles.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/unassign_device_from_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/update_vehicle.dart';
import 'package:cargasafe/fleet/application/usecases/vehicles/update_vehicle_status.dart';

import 'package:cargasafe/fleet/presentation/providers/fleet_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ================= DASHBOARD wiring =================
    final dashboardDS = DashboardRemoteDataSource();
    final dashboardRepo = DashboardRepository(remoteDataSource: dashboardDS);
    final dashboardService = DashboardService(repository: dashboardRepo);

    // ================= FLEET wiring =================
    final fleetApi = FleetApiService(baseUrl: AppConfig.baseUrl);

    // Datasources
    final deviceDS = DeviceRemoteDataSource(fleetApi);
    final vehicleDS = VehicleRemoteDataSource(fleetApi);

    // Repositories
    final deviceRepo = DeviceRepositoryImpl(deviceDS);
    final vehicleRepo = VehicleRepositoryImpl(vehicleDS);

    // Provider con todos los casos de uso
    final fleetProvider = FleetProvider(
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

    // ================= ROUTER =================
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: 'dashboard',
          builder: (_, __) => const DashboardPage(),
        ),
        GoRoute(
          path: '/alerts',
          name: 'alerts',
          builder: (_, __) => const AlertsPage(),
        ),
        // Mezclamos las rutas de Fleet
        ...fleetRoutes,
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardProvider(service: dashboardService),
        ),
        ChangeNotifierProvider(
          create: (_) => fleetProvider,
        ),
      ],
      child: MaterialApp.router(
        title: 'CargaSafe',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
