import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Domain
import '../../domain/entities/vehicle_status.dart';
import '../../domain/entities/vehicle_type.dart';

// Application (store/facade)
import '../providers/fleet_provider.dart';

// UI widgets
import '../widgets/vehicle_create_edit_dialog.dart';
import '../widgets/filters_toolbar.dart';
import '../widgets/kpi_cards.dart';
import '../styles/fleet_styles.dart';
import 'package:cargasafe/shared/presentation/widgets/app_scaffold.dart';

class VehicleManagementPage extends StatefulWidget {
  const VehicleManagementPage({super.key});

  @override
  State<VehicleManagementPage> createState() => _VehicleManagementPageState();
}

class _VehicleManagementPageState extends State<VehicleManagementPage> {
  String _search = '';
  VehicleStatus? _status;
  VehicleType? _type;

  @override
  void initState() {
    super.initState();
    // Carga inicial
    Future.microtask(() => context.read<FleetProvider>().loadVehicles());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FleetProvider>();

    final rows = provider.vehicles.where((v) {
      final q = _search.toLowerCase();
      final matchesQ =
          q.isEmpty ||
          v.plate.toLowerCase().contains(q) ||
          v.type.name.toLowerCase().contains(q) ||
          v.capabilities.any((c) => c.toLowerCase().contains(q)) ||
          v.deviceImeis.any((i) => i.toLowerCase().contains(q));
      final matchesStatus = _status == null || v.status == _status;
      final matchesType = _type == null || v.type == _type;
      return matchesQ && matchesStatus && matchesType;
    }).toList();

    final total = provider.vehicles.length;
    final inService = provider.vehicles
        .where((v) => v.status == VehicleStatus.IN_SERVICE)
        .length;

    return AppScaffold(
      title: 'Vehicles',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final res = await VehicleCreateEditDialog.show(context);
          if (res != null)
            await context.read<FleetProvider>().createVehicle(res);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // KPIs
            Row(
              children: [
                Expanded(
                  child: KpiCard(
                    title: 'Vehicles Available',
                    value: '$inService',
                    subtitle: 'of $total total',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: KpiCard(
                    title: 'In Service',
                    value: '$inService',
                    subtitle: 'active assignments',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Toolbar (search + filtros)
            FiltersToolbar(
              searchHint: 'Search by plate, type…',
              onSearch: (s) => setState(() => _search = s),
              right: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<VehicleStatus?>(
                    hint: const Text('All statuses'),
                    value: _status,
                    items: [null, ...VehicleStatus.values]
                        .map(
                          (s) => DropdownMenuItem(
                            value: s,
                            child: Text(
                              s == null ? 'All statuses' : _titleCase(s.name),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _status = v),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<VehicleType?>(
                    hint: const Text('All types'),
                    value: _type,
                    items: [null, ...VehicleType.values]
                        .map(
                          (t) => DropdownMenuItem(
                            value: t,
                            child: Text(
                              t == null ? 'All types' : t.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _type = v),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            if (provider.loading) const LinearProgressIndicator(),
            if (provider.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  provider.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 8),

            // Lista con pull-to-refresh
            Expanded(
              child: Container(
                decoration: FleetStyles.cardDeco,
                child: RefreshIndicator(
                  onRefresh: () => context.read<FleetProvider>().loadVehicles(),
                  child: rows.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 48),
                            Center(
                              child: Text(
                                'No vehicles found',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            SizedBox(height: 48),
                          ],
                        )
                      : ListView.separated(
                          itemCount: rows.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (_, i) {
                            final v = rows[i];
                            final subtitle = [
                              v.type.name.toUpperCase(),
                              _titleCase(v.status.name),
                              if (v.deviceImeis.isNotEmpty)
                                'IoT: ${v.deviceImeis.first}'
                                    '${v.deviceImeis.length > 1 ? ' (+${v.deviceImeis.length - 1})' : ''}',
                            ].join(' • ');

                            return ListTile(
                              title: Text(v.plate),
                              subtitle: Text(subtitle),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    tooltip: 'View',
                                    icon: const Icon(Icons.visibility),
                                    onPressed: (v.id == null)
                                        ? null
                                        : () => context.push(
                                            '/fleet/vehicles/${v.id}',
                                          ),
                                  ),
                                  IconButton(
                                    tooltip: 'Edit',
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      final next =
                                          await VehicleCreateEditDialog.show(
                                            context,
                                            initial: v,
                                          );
                                      if (next != null) {
                                        await context
                                            .read<FleetProvider>()
                                            .updateVehicle(next);
                                      }
                                    },
                                  ),
                                  IconButton(
                                    tooltip: 'Delete',
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: (v.id == null)
                                        ? null
                                        : () async => context
                                              .read<FleetProvider>()
                                              .deleteVehicle(v.id!),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _titleCase(String s) => s
      .split('_')
      .map((p) => p.isEmpty ? '' : '${p[0]}${p.substring(1).toLowerCase()}')
      .join(' ');
}
