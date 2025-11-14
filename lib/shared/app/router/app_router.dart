import 'package:cargasafe/alerts/presentation/routing/alert_routes.dart';
import 'package:cargasafe/dashboard/presentation/routing/dashboard_routes.dart';
import 'package:cargasafe/fleet/presentation/routing/fleet_routes.dart';
import 'package:go_router/go_router.dart';

import '../layout/main_layout.dart';
import 'package:cargasafe/shared/presentation/pages/page_not_found.dart';

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  errorBuilder: (context, state) => const PageNotFound(),
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [...dashboardRoutes, ...alertRoutes, ...fleetRoutes],
    ),
  ],
);
