import 'package:cargasafe/trips/application/trips_bloc.dart';
import 'package:cargasafe/trips/application/trips_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/model/trip.dart';

class TripTableListWidget extends StatefulWidget {
  const TripTableListWidget({super.key});

  @override
  State<TripTableListWidget> createState() => _TripTableListWidgetState();
}

class _TripTableListWidgetState extends State<TripTableListWidget> {
  String search = "";
  String filter = "all";
  String order = "desc";

  Trip? selected;
  bool showToast = false;
  String toastMessage = "";

  @override
  void initState() {
    super.initState();
    context.read<TripsBloc>().loadTrips();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsBloc, TripsState>(
      builder: (context, state) {
        final list = _applyFilters(state.trips.data);

        return Column(
          children: [
            _buildFilters(),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (_, i) {
                  final trip = list[i];
                  return ListTile(
                    title: Text("Trip #${trip.id}"),
                    subtitle: Text("Driver: ${trip.driverId}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () =>
                              Navigator.pushNamed(context, "/trips/${trip.id}"),
                        ),
                        if (trip.isCreated())
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _openModifyModal(trip),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (showToast)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  toastMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        );
      },
    );
  }

  //-------------------------------------------------------------------------
  // FILTERS
  //-------------------------------------------------------------------------

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Search"),
            onChanged: (v) => setState(() => search = v),
          ),
          Row(
            children: [
              DropdownButton<String>(
                value: filter,
                items: const [
                  DropdownMenuItem(value: "all", child: Text("All")),
                  DropdownMenuItem(value: "0", child: Text("Completado")),
                  DropdownMenuItem(value: "1", child: Text("Cancelado")),
                  DropdownMenuItem(value: "2", child: Text("En curso")),
                  DropdownMenuItem(value: "3", child: Text("Programado")),
                ],
                onChanged: (v) => setState(() => filter = v!),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: order,
                items: const [
                  DropdownMenuItem(value: "desc", child: Text("Recent")),
                  DropdownMenuItem(value: "asc", child: Text("Oldest")),
                ],
                onChanged: (v) => setState(() => order = v!),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Trip> _applyFilters(List<Trip> items) {
    var list = [...items];

    if (search.isNotEmpty) {
      final q = search.toLowerCase();
      list = list
          .where(
            (t) =>
                t.id.toString().contains(q) ||
                t.driverId.toString().contains(q),
          )
          .toList();
    }

    if (order == "desc") {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    return list;
  }

  //-------------------------------------------------------------------------
  // MODIFY BOTTOM SHEET
  //-------------------------------------------------------------------------

  void _openModifyModal(Trip trip) {
    selected = trip;

    showModalBottomSheet(context: context, builder: (_) => _buildModifySheet());
  }

  Widget _buildModifySheet() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Modificar viaje", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _confirmModify(),
            child: const Text("Guardar cambios"),
          ),
        ],
      ),
    );
  }

  void _confirmModify() {
    Navigator.pop(context);

    setState(() {
      toastMessage = "Trip updated";
      showToast = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => showToast = false);
    });
  }
}
