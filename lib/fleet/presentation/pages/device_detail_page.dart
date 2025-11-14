import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fleet_provider.dart';
import '../styles/fleet_styles.dart';
import '../../domain/entities/device.dart';

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
    setState(() { _device = d; _loading = false; });
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
      appBar: AppBar(title: const Text('Device Detail')),
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
                    Text('IMEI: ${_device!.imei}', style: Theme.of(context).textTheme.titleLarge),
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
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                FilledButton(
                  onPressed: () async {
                    await p.updateDeviceOnline(_device!.id!, !_device!.online);
                    await _fetch();
                  },
                  child: Text(_device!.online ? 'Set Offline' : 'Set Online'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await p.updateDeviceFirmware(_device!.id!, 'v1.0.${DateTime.now().second}');
                    await _fetch();
                  },
                  child: const Text('Bump firmware'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final next = Device(
                      id: _device!.id,
                      imei: _device!.imei,
                      firmware: _device!.firmware,
                      online: _device!.online,
                      vehiclePlate: null,
                    );
                    await p.updateDevice(next);
                    await _fetch();
                  },
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
