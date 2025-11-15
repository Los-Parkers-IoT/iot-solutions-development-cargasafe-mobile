import 'package:cargasafe/trips/application/trips_bloc.dart';
import 'package:cargasafe/trips/application/trips_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripTotalSummaryWidget extends StatelessWidget {
  const TripTotalSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsBloc, TripsState>(
      builder: (context, state) {
        final summary = state.summary;

        if (summary.loading) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: LinearProgressIndicator(),
          );
        }

        if (summary.error != null) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              summary.error!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final data = summary.data;
        if (data == null) return const SizedBox();

        final trips = data["totalTrips"];

        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _item("Today", trips["today"]),
              _item("Yesterday", trips["yesterday"]),
              _item("Last 7 days", trips["last7Days"]),
              _item("Last year", trips["lastYear"]),
            ],
          ),
        );
      },
    );
  }

  Widget _item(String label, Object value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(value.toString()),
        ],
      ),
    );
  }
}
