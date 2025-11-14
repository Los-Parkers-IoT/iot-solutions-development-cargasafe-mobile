import 'package:cargasafe/shared/helpers/async_state.dart';
import 'package:cargasafe/trips/domain/model/trip.dart';
import 'package:cargasafe/trips/infrastructure/delivery_order_api.dart';
import 'package:cargasafe/trips/infrastructure/trip_api.dart';

import 'trips_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripsApi tripsApi = TripsApi();
  final DeliveryOrdersApi deliveryOrdersApi = DeliveryOrdersApi();

  TripsCubit() : super(TripsState.initial()) {}

  // -----------------------------------------------------
  // LOAD TRIPS
  // -----------------------------------------------------
  Future<void> loadTrips() async {
    emit(state.copyWith(trips: state.trips.copyWith(loading: true)));

    try {
      final trips = await tripsApi.getTrips();
      emit(state.copyWith(trips: AsyncState(data: trips)));
    } catch (_) {
      emit(
        state.copyWith(
          trips: state.trips.copyWith(
            loading: false,
            error: "Failed to load trips",
          ),
        ),
      );
    }
  }

  // -----------------------------------------------------
  // LOAD TRIP BY ID
  // -----------------------------------------------------
  Future<void> loadTripById(int id) async {
    emit(state.copyWith(trip: state.trip.copyWith(loading: true)));

    try {
      final t = await tripsApi.getTripById(id);
      emit(state.copyWith(trip: AsyncState(data: t)));
    } catch (_) {
      emit(
        state.copyWith(
          trip: state.trip.copyWith(
            loading: false,
            error: "Failed to load trip",
          ),
        ),
      );
    }
  }

  // -----------------------------------------------------
  // LOAD SUMMARY
  // -----------------------------------------------------
  Future<void> loadTotalTripsSummary() async {
    emit(state.copyWith(summary: state.summary.copyWith(loading: true)));

    try {
      final s = await tripsApi.getTotalTripsSummary();
      emit(state.copyWith(summary: AsyncState(data: s)));
    } catch (_) {
      emit(
        state.copyWith(
          summary: state.summary.copyWith(
            loading: false,
            error: "Failed to load summary",
          ),
        ),
      );
    }
  }

  // -----------------------------------------------------
  // MARK ORDER AS DELIVERED
  // -----------------------------------------------------
  Future<void> markOrderAsDelivered(int orderId) async {
    final currentTrip = state.trip.data;
    if (currentTrip == null) return;

    final order = currentTrip.deliveryOrders.firstWhere(
      (o) => o.id == orderId,
      orElse: () => throw Exception("Order not found"),
    );

    try {
      await deliveryOrdersApi.markAsDelivered(orderId);

      // mutar entidad (igual que en Angular)
      order.markAsDelivered();

      // NO creamos otro trip
      emit(state.copyWith(trip: AsyncState(data: currentTrip)));
    } catch (_) {
      // manejar error si quieres
    }
  }

  // -----------------------------------------------------
  // CREATE TRIP
  // -----------------------------------------------------
  Future<void> createTrip(Trip trip) async {
    await tripsApi.createTrip(trip);
  }
}
