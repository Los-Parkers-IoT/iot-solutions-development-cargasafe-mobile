import 'package:cargasafe/shared/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vehicle.dart';
import '../../domain/entities/vehicle_status.dart';
import '../providers/fleet_provider.dart';
import '../styles/fleet_styles.dart';

class VehicleDetailPage extends StatefulWidget {
  const VehicleDetailPage({super.key, required this.id});
  final int id;

  @override
  State<VehicleDetailPage> createState() => _VehicleDetailPageState();
}

class _VehicleDetailPageState extends State<VehicleDetailPage> {
  Vehicle? _vehicle;
  bool _loading = true;

  Future<void> _fetch() async {
    final v = await context.read<FleetProvider>().loadVehicleById(widget.id);
    setState(() { _vehicle = v; _loading = false; });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_fetch);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<FleetProvider>();

    return AppScaffold(
      title: 'Vehicle Detail',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : (_vehicle == null)
            ? const Center(child: Text('Vehicle not found'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: FleetStyles.cardDeco,
              padding: FleetStyles.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Plate: ${_vehicle!.plate}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text('Type: ${_vehicle!.type.name.toUpperCase()}'),
                  Text('Status: ${_vehicle!.status.name.replaceAll('_', ' ').toLowerCase()}'),
                  Text('Odometer: ${_vehicle!.odometerKm.toStringAsFixed(0)} km'),
                  Text('Capabilities: ${_vehicle!.capabilities.isNotEmpty ? _vehicle!.capabilities.join(', ') : '—'}'),
                  Text('IoT Devices: ${_vehicle!.deviceImeis.isNotEmpty ? _vehicle!.deviceImeis.join(', ') : '—'}'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (p.loading) const LinearProgressIndicator(),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                FilledButton(
                  onPressed: () async {
                    await p.updateVehicleStatus(_vehicle!.id!, VehicleStatus.IN_SERVICE);
                    await _fetch();
                  },
                  child: const Text('Set In Service'),
                ),
                FilledButton.tonal(
                  onPressed: () async {
                    await p.updateVehicleStatus(_vehicle!.id!, VehicleStatus.OUT_OF_SERVICE);
                    await _fetch();
                  },
                  child: const Text('Set Out of Service'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
