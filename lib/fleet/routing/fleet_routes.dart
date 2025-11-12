import 'package:go_router/go_router.dart';
import '../presentation/pages/device_management_page.dart';
import '../presentation/pages/device_detail_page.dart';
import '../presentation/pages/vehicle_management_page.dart';
import '../presentation/pages/vehicle_detail_page.dart';

final List<GoRoute> fleetRoutes = [
  GoRoute(path: '/fleet/vehicles',        builder: (_, __) => const VehicleManagementPage()),
  GoRoute(path: '/fleet/vehicles/:id',    builder: (ctx, st) => VehicleDetailPage(id: int.parse(st.pathParameters['id']!))),
  GoRoute(path: '/fleet/devices',         builder: (_, __) => const DeviceManagementPage()),
  GoRoute(path: '/fleet/devices/:id',     builder: (ctx, st) => DeviceDetailPage(id: int.parse(st.pathParameters['id']!))),
];
