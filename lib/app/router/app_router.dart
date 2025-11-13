import 'package:cargasafe/alerts/presentation/routing/alert_routes.dart';
import 'package:cargasafe/dashboard/presentation/routing/dashboard_routes.dart';
import 'package:go_router/go_router.dart';

import '../layout/main_layout.dart';
import '../../fleet/routing/fleet_routes.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        ...dashboardRoutes,
        ...alertRoutes,
        ...fleetRoutes,
      ],
    ),
  ],
);

