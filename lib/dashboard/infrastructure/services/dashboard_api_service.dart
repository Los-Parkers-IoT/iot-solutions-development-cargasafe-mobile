import 'dart:io';
import '../../../shared/infrastructure/services/base_service.dart';
import 'dashboard_mock_service.dart';

class DashboardApiService extends BaseService {
  // 🔧 CONFIGURACIÓN: Cambiar a false para usar API real
  static const bool USE_MOCK_DATA = true;

  // Endpoints
  static const String analyticsTripsEndpoint = '/analytics-trips';
  static const String analyticsAlertsEndpoint = '/analytics-alerts';
  static const String incidentsByMonthEndpoint = '/incidentsByMonth';

  final DashboardMockService _mockService = DashboardMockService();

  DashboardApiService() : super(baseUrl: _getBaseUrl());

  static String _getBaseUrl() {
    // Para Android Emulator
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    // Para iOS Simulator y otras plataformas
    return 'http://localhost:3000';
  }

  // Métodos específicos del Dashboard

  /// Get all trips
  Future<List<dynamic>> getTrips() async {
    if (USE_MOCK_DATA) {
      return await _mockService.getTrips();
    }

    final response = await dio.get(analyticsTripsEndpoint);
    if (response.statusCode == 200) {
      return response.data as List<dynamic>;
    }
    throw Exception('Failed to load trips: ${response.statusCode}');
  }

  /// Get trip by ID
  Future<dynamic> getTripById(String id) async {
    if (USE_MOCK_DATA) {
      return await _mockService.getTripById(id);
    }

    final response = await dio.get('$analyticsTripsEndpoint/$id');
    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Failed to load trip: ${response.statusCode}');
  }

  /// Get all alerts
  Future<List<dynamic>> getAlerts() async {
    if (USE_MOCK_DATA) {
      return await _mockService.getAlerts();
    }

    final response = await dio.get(analyticsAlertsEndpoint);
    if (response.statusCode == 200) {
      return response.data as List<dynamic>;
    }
    throw Exception('Failed to load alerts: ${response.statusCode}');
  }

  /// Get alerts by trip ID
  Future<List<dynamic>> getAlertsByTripId(String tripId) async {
    if (USE_MOCK_DATA) {
      return await _mockService.getAlertsByTripId(tripId);
    }

    final response = await dio.get(
      analyticsAlertsEndpoint,
      queryParameters: {'tripId': tripId},
    );
    if (response.statusCode == 200) {
      return response.data as List<dynamic>;
    }
    throw Exception('Failed to load alerts: ${response.statusCode}');
  }

  /// Get incidents by month
  Future<List<dynamic>> getIncidentsByMonth() async {
    if (USE_MOCK_DATA) {
      return await _mockService.getIncidentsByMonth();
    }

    final response = await dio.get(incidentsByMonthEndpoint);
    if (response.statusCode == 200) {
      return response.data as List<dynamic>;
    }
    throw Exception('Failed to load incidents: ${response.statusCode}');
  }
}
