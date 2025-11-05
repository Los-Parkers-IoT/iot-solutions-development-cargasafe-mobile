import '../domain/entities/trip.dart';
import '../domain/entities/alert.dart';
import '../domain/entities/incidents_by_month.dart';
import '../infrastructure/repositories/dashboard_repository.dart';

class DashboardService {
  final DashboardRepository repository;

  DashboardService({required this.repository});

  Future<List<Trip>> fetchTrips() async {
    return await repository.getTrips();
  }

  Future<Trip> fetchTripById(String id) async {
    return await repository.getTripById(id);
  }

  Future<List<Alert>> fetchAlerts() async {
    return await repository.getAlerts();
  }

  Future<List<Alert>> fetchAlertsByTripId(String tripId) async {
    return await repository.getAlertsByTripId(tripId);
  }

  Future<List<IncidentsByMonth>> fetchIncidentsByMonth() async {
    return await repository.getIncidentsByMonth();
  }

  // Método helper para cargar todos los datos del dashboard
  Future<Map<String, dynamic>> fetchDashboardData() async {
    try {
      final results = await Future.wait([
        fetchTrips(),
        fetchAlerts(),
        fetchIncidentsByMonth(),
      ]);

      return {
        'trips': results[0] as List<Trip>,
        'alerts': results[1] as List<Alert>,
        'incidents': results[2] as List<IncidentsByMonth>,
      };
    } catch (e) {
      throw Exception('Error loading dashboard data: $e');
    }
  }
}

