import 'package:cargasafe/trips/presentation/screens/trips_list_screen.dart';
import 'package:go_router/go_router.dart';

final List<GoRoute> tripsRoutes = [
  GoRoute(
    path: '/trips',
    name: 'trips',
    builder: (_, __) => const TripsListScreen(),
  ),
];
