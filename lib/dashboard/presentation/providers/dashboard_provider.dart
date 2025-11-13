import 'package:flutter/foundation.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/alert.dart';
import '../../domain/entities/incidents_by_month.dart';
import '../../application/dashboard_service.dart';

class DashboardProvider with ChangeNotifier {
  final DashboardService service;

  DashboardProvider({required this.service});

  // Private state
  List<Trip> _trips = [];
  List<Alert> _alerts = [];
  List<IncidentsByMonth> _incidents = [];
  bool _isLoading = false;
  String? _error;

  // Public getters
  List<Trip> get trips => _trips;
  List<Alert> get alerts => _alerts;
  List<IncidentsByMonth> get incidents => _incidents;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Computed properties
  int get totalTrips => _trips.length;
  int get activeTrips => _trips.where((trip) => trip.isInProgress).length;
  int get totalAlerts => _alerts.length;
  int get pendingAlerts => _alerts.where((alert) => !alert.resolved).length;

  // Load all dashboard data
  Future<void> loadDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await service.fetchDashboardData();
      _trips = data['trips'] as List<Trip>;
      _alerts = data['alerts'] as List<Alert>;
      _incidents = data['incidents'] as List<IncidentsByMonth>;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _trips = [];
      _alerts = [];
      _incidents = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get trip by ID
  Future<Trip?> getTripById(String id) async {
    try {
      final cachedTrip = _trips.firstWhere(
        (trip) => trip.id == id,
        orElse: () => throw Exception('Not found in cache'),
      );
      return cachedTrip;
    } catch (e) {
      try {
        return await service.fetchTripById(id);
      } catch (e) {
        _error = e.toString();
        notifyListeners();
        return null;
      }
    }
  }

  // Get alerts by trip ID
  Future<List<Alert>> getAlertsByTripId(String tripId) async {
    try {
      final tripAlerts = await service.fetchAlertsByTripId(tripId);
      return tripAlerts;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}

