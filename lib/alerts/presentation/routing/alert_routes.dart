import 'package:cargasafe/alerts/presentation/pages/alert_page/alerts_page.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> alertRoutes = [
  GoRoute(
    path: '/alerts',
    name: 'alerts',
    builder: (_, __) => const AlertsPage(),
  ),
];