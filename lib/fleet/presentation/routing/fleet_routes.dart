import 'package:cargasafe/fleet/presentation/pages/device_management_page.dart';
import 'package:go_router/go_router.dart';
import 'package:cargasafe/fleet/presentation/pages/vehicle_management_page.dart';
import 'package:cargasafe/fleet/presentation/pages/device_detail_page.dart';
import 'package:cargasafe/fleet/presentation/pages/vehicle_detail_page.dart';

// fleet_routes.dart
final List<GoRoute> fleetRoutes = [
  GoRoute(
    path: '/fleet/vehicles',
    name: 'fleet-vehicles',
    builder: (_, __) => const VehicleManagementPage(),
  ),
  GoRoute(
    path: '/fleet/devices',
    name: 'fleet-devices',
    builder: (_, __) => const DeviceManagementPage(),
  ),
  GoRoute(
    path: '/fleet/vehicles/:id',
    name: 'fleet-vehicle-detail',
    builder: (ctx, st) =>
        VehicleDetailPage(id: int.parse(st.pathParameters['id']!)),
  ),
  GoRoute(
    path: '/fleet/devices/:id',
    name: 'fleet-device-detail',
    builder: (ctx, st) =>
        DeviceDetailPage(id: int.parse(st.pathParameters['id']!)),
  ),
];
