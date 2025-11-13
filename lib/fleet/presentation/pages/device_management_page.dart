import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/fleet_provider.dart';
import '../widgets/device_create_edit_dialog.dart';
import '../widgets/filters_toolbar.dart';
import '../styles/fleet_styles.dart';
import '../../../shared/presentation/widgets/app_scaffold.dart';

class DeviceManagementPage extends StatefulWidget {
  const DeviceManagementPage({super.key});

  @override
  State<DeviceManagementPage> createState() => _DeviceManagementPageState();
}

class _DeviceManagementPageState extends State<DeviceManagementPage> {
  String _search = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<FleetProvider>().loadDevices());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FleetProvider>();
    final rows = provider.devices.where((d) {
      final q = _search.toLowerCase();
      return q.isEmpty ||
          d.imei.toLowerCase().contains(q) ||
          (d.vehiclePlate ?? '').toLowerCase().contains(q);
    }).toList();

    return AppScaffold(
      title: 'IoT Devices',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final res = await DeviceCreateEditDialog.show(context);
          if (res != null) await context.read<FleetProvider>().createDevice(res);
        },
        icon: const Icon(Icons.add),
        label: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FiltersToolbar(
              searchHint: 'Search by IMEI or vehicle…',
              onSearch: (s) => setState(() => _search = s),
              right: DropdownButton<String>(
                value: null,
                hint: const Text('All states'),
                items: const [
                  DropdownMenuItem(value: 'online', child: Text('Online')),
                  DropdownMenuItem(value: 'offline', child: Text('Offline')),
                ],
                onChanged: (v) async {
                  if (v == null) {
                    await context.read<FleetProvider>().loadDevices();
                  } else {
                    await context.read<FleetProvider>().findDevicesByOnline(v == 'online');
                  }
                },
              ),
            ),
            const SizedBox(height: 12),
            if (provider.loading) const LinearProgressIndicator(),
            if (provider.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(provider.error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: FleetStyles.cardDeco,
                child: ListView.separated(
                  itemCount: rows.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) {
                    final d = rows[i];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: d.online ? Colors.green : Colors.grey,
                        child: const Icon(Icons.memory, color: Colors.white),
                      ),
                      title: Text(d.imei),
                      subtitle: Text(d.vehiclePlate ?? '—'),
                      trailing: Wrap(
                        spacing: 0,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.visibility),
                            onPressed: () => context.push('/fleet/devices/${d.id}'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              final next = await DeviceCreateEditDialog.show(context, initial: d);
                              if (next != null) await context.read<FleetProvider>().updateDevice(next);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: (d.id == null)
                                ? null
                                : () async => context.read<FleetProvider>().deleteDevice(d.id!),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
