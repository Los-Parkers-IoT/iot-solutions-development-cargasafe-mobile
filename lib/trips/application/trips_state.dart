import 'package:equatable/equatable.dart';
import 'package:cargasafe/shared/helpers/async_state.dart';
import 'package:cargasafe/trips/domain/model/trip.dart';

class TripsState extends Equatable {
  final AsyncState<List<Trip>> trips;
  final AsyncState<Trip?> trip;
  final AsyncState<Map<String, dynamic>?> summary;

  const TripsState({
    required this.trips,
    required this.trip,
    required this.summary,
  });

  factory TripsState.initial() => TripsState(
    trips: AsyncState.initial([]),
    trip: AsyncState.initial(null),
    summary: AsyncState.initial(null),
  );

  TripsState copyWith({
    AsyncState<List<Trip>>? trips,
    AsyncState<Trip?>? trip,
    AsyncState<Map<String, dynamic>?>? summary,
  }) {
    return TripsState(
      trips: trips ?? this.trips,
      trip: trip ?? this.trip,
      summary: summary ?? this.summary,
    );
  }

  @override
  List<Object?> get props => [trips, trip, summary];
}
