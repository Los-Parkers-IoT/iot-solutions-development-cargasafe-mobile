import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fleet_provider.dart';
import '../styles/fleet_styles.dart';
import '../../domain/entities/device.dart';
import 'package:go_router/go_router.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({super.key, required this.id});
  final int id;

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  Device? _device;
  bool _loading = true;

  Future<void> _fetch() async {
    final d = await context.read<FleetProvider>().loadDeviceById(widget.id);
    if (!mounted) return;
    setState(() {
      _device = d;
      _loading = false;
    });
  }


  Future<void> _unlinkVehicle(FleetProvider p) async {
    final plate = _device?.vehiclePlate;
    if (plate == null) return;

    // 1. Buscar el vehicle por placa
    final vehicle = await p.findVehicleByPlate(plate);

    if (!mounted) return;

    if (vehicle == null || vehicle.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vehicle $plate not found')),
      );
      return;
    }

    // 2. Llamar al use case correcto
    await p.unassignDeviceFromVehicle(vehicle.id!, _device!.imei);

    // 3. Refrescar el detalle del device
    await _fetch();
  }





  Future<void> _openUpdateFirmwareDialog(
      BuildContext context, FleetProvider p) async {
    final controller = TextEditingController(text: _device?.firmware ?? '');

    final newFirmware = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update firmware'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Firmware version',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Update'),
          ),
        ],
      ),
    );

    if (newFirmware != null &&
        newFirmware.isNotEmpty &&
        _device != null) {
      // 🔁 En vez de usar el endpoint /firmware, usamos el update general:
      final updated = _device!.copyWith(firmware: newFirmware);

      await p.updateDevice(updated); // PUT /fleet/devices/{id}
      await _fetch();                // refrescar detalle
    }
  }

  Future<void> _openAssignVehicleDialog(
      BuildContext context, FleetProvider p) async {
    await p.loadVehicles();
    final vehicles = p.vehicles;

    if (!mounted) return;

    if (vehicles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No vehicles available')),
      );
      return;
    }

    int? selectedId = _device?.vehiclePlate != null
        ? vehicles
        .firstWhere(
          (v) => v.plate == _device!.vehiclePlate,
      orElse: () => vehicles.first,
    )
        .id
        : vehicles.first.id;

    final result = await showDialog<int>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setInnerState) {
          return AlertDialog(
            title: const Text('Assign to vehicle'),
            content: DropdownButtonFormField<int>(
              value: selectedId,
              decoration: const InputDecoration(labelText: 'Vehicle'),
              items: vehicles
                  .map(
                    (v) => DropdownMenuItem(
                  value: v.id,
                  child: Text('${v.plate} — ${v.type.name}'),
                ),
              )
                  .toList(),
              onChanged: (value) => setInnerState(() => selectedId = value),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: selectedId == null
                    ? null
                    : () => Navigator.pop(ctx, selectedId),
                child: const Text('Assign'),
              ),
            ],
          );
        },
      ),
    );

    if (result != null && _device != null) {
      await p.assignDeviceToVehicle(result, _device!.imei);
      await _fetch();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(_fetch);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<FleetProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Puedes usar pop() o ir directo a la ruta de lista:
          // onPressed: () => context.pop(),
          onPressed: () => context.go('/fleet/devices'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : (_device == null)
            ? const Center(child: Text('Device not found'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: FleetStyles.cardDeco,
              padding: FleetStyles.cardPadding,
              child: DefaultTextStyle.merge(
                style: const TextStyle(fontSize: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IMEI: ${_device!.imei}',
                      style:
                      Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('Status: ${_device!.online ? 'Online' : 'Offline'}'),
                    Text('Firmware: ${_device!.firmware}'),
                    Text('Vehicle: ${_device!.vehiclePlate ?? '—'}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (p.loading) const LinearProgressIndicator(),
            if (p.error != null) ...[
              const SizedBox(height: 8),
              Text(
                p.error!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () async {
                    await p.updateDeviceOnline(
                      _device!.id!,
                      !_device!.online,
                    );
                    await _fetch();
                  },
                  child: Text(
                    _device!.online ? 'Set Offline' : 'Set Online',
                  ),
                ),
                OutlinedButton(
                  onPressed: () =>
                      _openUpdateFirmwareDialog(context, p),
                  child: const Text('Update firmware'),
                ),
                OutlinedButton(
                  onPressed: () =>
                      _openAssignVehicleDialog(context, p),
                  child: const Text('Link to vehicle'),
                ),
                OutlinedButton(
                  onPressed: (_device?.vehiclePlate == null)
                      ? null
                      : () => _unlinkVehicle(p),
                  child: const Text('Unlink vehicle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}