import '../../domain/entities/trip.dart';
import '../../domain/entities/alert.dart';
import '../../domain/entities/incidents_by_month.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepository({required this.remoteDataSource});

  Future<List<Trip>> getTrips() async {
    try {
      return await remoteDataSource.getTrips();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<Trip> getTripById(String id) async {
    try {
      return await remoteDataSource.getTripById(id);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<List<Alert>> getAlerts() async {
    try {
      return await remoteDataSource.getAlerts();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<List<Alert>> getAlertsByTripId(String tripId) async {
    try {
      return await remoteDataSource.getAlertsByTripId(tripId);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  Future<List<IncidentsByMonth>> getIncidentsByMonth() async {
    try {
      return await remoteDataSource.getIncidentsByMonth();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}

