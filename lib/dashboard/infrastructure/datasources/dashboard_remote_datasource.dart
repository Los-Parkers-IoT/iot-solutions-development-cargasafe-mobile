import '../../domain/entities/trip.dart';
import '../../domain/entities/alert.dart';
import '../../domain/entities/incidents_by_month.dart';
import '../../domain/enums/alert_type.dart';
import '../../domain/enums/alert_severity.dart';
import '../../domain/enums/trip_status.dart';
import '../../domain/value_objects/sensor_data.dart';
import '../services/dashboard_api_service.dart';

class DashboardRemoteDataSource {
  final DashboardApiService _apiService;

  DashboardRemoteDataSource({DashboardApiService? apiService})
      : _apiService = apiService ?? DashboardApiService();

  // Get all trips
  Future<List<Trip>> getTrips() async {
    try {
      final jsonList = await _apiService.getTrips();
      return jsonList.map((json) => _tripFromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching trips: $e');
    }
  }

  // Get trip by ID
  Future<Trip> getTripById(String id) async {
    try {
      final jsonData = await _apiService.getTripById(id);
      return _tripFromJson(jsonData);
    } catch (e) {
      throw Exception('Error fetching trip: $e');
    }
  }

  // Get all alerts
  Future<List<Alert>> getAlerts() async {
    try {
      final jsonList = await _apiService.getAlerts();
      return jsonList.map((json) => _alertFromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching alerts: $e');
    }
  }

  // Get alerts by trip ID
  Future<List<Alert>> getAlertsByTripId(String tripId) async {
    try {
      final jsonList = await _apiService.getAlertsByTripId(tripId);
      return jsonList.map((json) => _alertFromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching alerts: $e');
    }
  }

  // Get incidents by month
  Future<List<IncidentsByMonth>> getIncidentsByMonth() async {
    try {
      final jsonList = await _apiService.getIncidentsByMonth();
      return jsonList.map((json) => _incidentsByMonthFromJson(json)).toList();
    } catch (e) {
      throw Exception('Error fetching incidents: $e');
    }
  }

  // Private mapper methods
  Trip _tripFromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id']?.toString() ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      origin: json['origin'] ?? '',
      destination: json['destination'] ?? '',
      vehiclePlate: json['vehiclePlate'] ?? '',
      driverName: json['driverName'] ?? '',
      cargoType: json['cargoType'] ?? '',
      status: TripStatus.fromString(json['status'] ?? 'PLANNED'),
      distance: (json['distance'] ?? 0.0).toDouble(),
      alertIds: json['alertIds'] != null
          ? List<String>.from(json['alertIds'].map((id) => id.toString()))
          : [],
    );
  }

  Alert _alertFromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id']?.toString() ?? '',
      tripId: json['tripId']?.toString() ?? '',
      deviceId: json['deviceId']?.toString() ?? '',
      vehiclePlate: json['vehiclePlate'] ?? '',
      type: AlertType.fromString(json['type'] ?? 'TEMPERATURE'),
      severity: AlertSeverity.fromString(json['severity'] ?? 'LOW'),
      timestamp: DateTime.parse(json['timestamp']),
      location: Location.fromJson(json['location'] ?? {}),
      sensorData: SensorData.fromJson(json['sensorData'] ?? {}),
      resolved: json['resolved'] ?? false,
    );
  }

  IncidentsByMonth _incidentsByMonthFromJson(Map<String, dynamic> json) {
    return IncidentsByMonth(
      id: json['id']?.toString() ?? '',
      month: json['month'] ?? '',
      year: json['year'] ?? DateTime.now().year,
      temperatureIncidents: json['temperatureIncidents'] ?? 0,
      movementIncidents: json['movementIncidents'] ?? 0,
      totalIncidents: json['totalIncidents'] ?? 0,
    );
  }
}

