import 'package:cargasafe/shared/presentation/widgets/app_scaffold.dart';
import 'package:cargasafe/trips/application/trips_bloc.dart';
import 'package:cargasafe/trips/presentation/widgets/trip_table_list_widget.dart';
import 'package:cargasafe/trips/presentation/widgets/trip_total_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripsListScreen extends StatelessWidget {
  const TripsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TripsBloc>();

    return AppScaffold(
      title: 'TripListScreen',
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, "/trips/create"),
          child: const Text("+ Create"),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TripTotalSummaryWidget(),
            Expanded(child: TripTableListWidget()),
          ],
        ),
      ),
    );
  }
}
