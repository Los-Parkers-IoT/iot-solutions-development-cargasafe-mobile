import 'package:cargasafe/shared/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/vehicle.dart';
import '../../domain/entities/vehicle_status.dart';
import '../providers/fleet_provider.dart';
import '../styles/fleet_styles.dart';
import '../../domain/entities/device.dart';

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


  Future<void> _openAssignDeviceDialog(BuildContext context, FleetProvider p) async {
    // Cargamos devices para tener data fresca
    await p.loadDevices();
    final available = p.devices.where((d) => d.vehiclePlate == null).toList();

    if (!mounted) return;

    if (available.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No available IoT devices to assign')),
      );
      return;
    }

    final selected = await showDialog<Device>(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Assign IoT Device'),
          children: [
            for (final d in available)
              SimpleDialogOption(
                onPressed: () => Navigator.of(ctx).pop(d),
                child: ListTile(
                  title: Text(d.imei),
                  subtitle: Text(d.online ? 'Online' : 'Offline'),
                ),
              ),
          ],
        );
      },
    );

    if (selected != null && _vehicle != null && _vehicle!.id != null) {
      await p.assignDeviceToVehicle(_vehicle!.id!, selected.imei);
      await _fetch();
    }
  }

  Future<void> _openUnassignDeviceDialog(BuildContext context, FleetProvider p) async {
    final v = _vehicle;
    if (v == null || v.id == null || v.deviceImeis.isEmpty) return;

    String? selectedImei;

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            title: const Text('Unassign IoT Device'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final imei in v.deviceImeis)
                  RadioListTile<String>(
                    title: Text(imei),
                    value: imei,
                    groupValue: selectedImei,
                    onChanged: (value) {
                      setInnerState(() => selectedImei = value);
                    },
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: selectedImei == null
                    ? null
                    : () => Navigator.pop(ctx, selectedImei),
                child: const Text('Unassign'),
              ),
            ],
          );
        },
      ),
    );

    if (result != null && v.id != null) {
      await p.unassignDeviceFromVehicle(v.id!, result);
      await _fetch();
    }
  }

  Future<void> _unassignAllDevices(FleetProvider p) async {
    final v = _vehicle;
    if (v == null || v.id == null || v.deviceImeis.isEmpty) return;

    for (final imei in v.deviceImeis) {
      await p.unassignDeviceFromVehicle(v.id!, imei);
    }
    await _fetch();
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
              runSpacing: 8,
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

                // 👇 NUEVO: Assign
                OutlinedButton(
                  onPressed: (_vehicle?.id == null)
                      ? null
                      : () => _openAssignDeviceDialog(context, p),
                  child: const Text('Assign IoT device'),
                ),

                // 👇 NUEVO: Unassign single
                OutlinedButton(
                  onPressed: (_vehicle?.id == null || _vehicle!.deviceImeis.isEmpty)
                      ? null
                      : () => _openUnassignDeviceDialog(context, p),
                  child: const Text('Unassign device'),
                ),

                // 👇 NUEVO: Unassign all
                OutlinedButton(
                  onPressed: (_vehicle?.id == null || _vehicle!.deviceImeis.isEmpty)
                      ? null
                      : () => _unassignAllDevices(p),
                  child: const Text('Unassign all'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
