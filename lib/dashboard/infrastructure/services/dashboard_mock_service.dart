import 'dart:convert';
import 'package:flutter/services.dart';

/// Mock service that loads data from JSON assets
/// Used for development when backend is not available
class DashboardMockService {
  // Simulated network delay (in milliseconds)
  static const int _networkDelay = 800;

  /// Get all trips from mock data
  Future<List<dynamic>> getTrips() async {
    await _simulateNetworkDelay();
    final String response = await rootBundle.loadString('assets/data/mock_trips.json');
    return json.decode(response) as List<dynamic>;
  }

  /// Get trip by ID from mock data
  Future<dynamic> getTripById(String id) async {
    await _simulateNetworkDelay();
    final trips = await getTrips();
    final trip = trips.firstWhere(
      (t) => t['id'] == id,
      orElse: () => throw Exception('Trip not found: $id'),
    );
    return trip;
  }

  /// Get all alerts from mock data
  Future<List<dynamic>> getAlerts() async {
    await _simulateNetworkDelay();
    final String response = await rootBundle.loadString('assets/data/mock_alerts.json');
    return json.decode(response) as List<dynamic>;
  }

  /// Get alerts filtered by trip ID
  Future<List<dynamic>> getAlertsByTripId(String tripId) async {
    await _simulateNetworkDelay();
    final alerts = await getAlerts();
    return alerts.where((alert) => alert['tripId'] == tripId).toList();
  }

  /// Get incidents by month from mock data
  Future<List<dynamic>> getIncidentsByMonth() async {
    await _simulateNetworkDelay();
    final String response = await rootBundle.loadString('assets/data/mock_incidents.json');
    return json.decode(response) as List<dynamic>;
  }

  /// Simulate network delay for realistic testing
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(Duration(milliseconds: _networkDelay));
  }
}
