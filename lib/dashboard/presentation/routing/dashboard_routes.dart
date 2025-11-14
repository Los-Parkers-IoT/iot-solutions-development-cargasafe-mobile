import 'package:cargasafe/dashboard/presentation/pages/dashboard_page/dashboard_page.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> dashboardRoutes = [
  GoRoute(
    path: '/dashboard',
    name: 'dashboard',
    builder: (_, __) => const DashboardPage(),
  ),
];


