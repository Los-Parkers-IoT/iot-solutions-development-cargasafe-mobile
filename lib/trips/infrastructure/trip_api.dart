import 'package:cargasafe/shared/core/app_config.dart';
import 'package:cargasafe/trips/domain/model/trip.dart';
import 'package:cargasafe/trips/infrastructure/trip_assembler.dart';
import 'package:cargasafe/trips/infrastructure/trip_response.dart';
import 'package:dio/dio.dart';

class TripsApi {
  final Dio _dio;
  final String endpoint = "/trips";
  final String baseUrl = AppConfig.baseUrl;

  TripsApi()
    : _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  String get _full => "$baseUrl$endpoint";

  // ----------------------------------------
  // GET ALL TRIPS
  // ----------------------------------------
  Future<List<Trip>> getTrips() async {
    final response = await _dio.get(_full);

    final list = (response.data as List)
        .map((json) => TripResource.fromJson(json))
        .toList();

    return list.map(TripAssembler.fromResource).toList();
  }

  // ----------------------------------------
  // GET TRIP BY ID
  // ----------------------------------------
  Future<Trip> getTripById(int id) async {
    final response = await _dio.get("$_full/$id");

    final resource = TripResource.fromJson(response.data);
    return TripAssembler.fromResource(resource);
  }

  // ----------------------------------------
  // GET TOTAL TRIPS SUMMARY  (mock igual que Angular)
  // ----------------------------------------
  Future<Map<String, dynamic>> getTotalTripsSummary() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      "totalTrips": {
        "today": 5,
        "yesterday": 8,
        "last7Days": 45,
        "lastYear": 520,
      },
    };
  }

  // ----------------------------------------
  // CREATE TRIP
  // ----------------------------------------
  Future<void> createTrip(Trip trip) async {
    final CreateTripResource payload = TripAssembler.toCreateResource(trip);

    await _dio.post(_full, data: payload.toJson());
  }
}
