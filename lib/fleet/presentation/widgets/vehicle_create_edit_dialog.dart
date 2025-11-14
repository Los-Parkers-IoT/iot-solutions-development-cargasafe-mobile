import 'package:flutter/material.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/entities/vehicle_status.dart';
import '../../domain/entities/vehicle_type.dart';

class VehicleCreateEditDialog extends StatefulWidget {
  const VehicleCreateEditDialog({super.key, this.initial});
  final Vehicle? initial;

  static Future<Vehicle?> show(BuildContext context, {Vehicle? initial}) {
    return showDialog<Vehicle>(
      context: context,
      builder: (_) => VehicleCreateEditDialog(initial: initial),
    );
  }

  @override
  State<VehicleCreateEditDialog> createState() =>
      _VehicleCreateEditDialogState();
}

class _VehicleCreateEditDialogState extends State<VehicleCreateEditDialog> {
  final _form = GlobalKey<FormState>();
  late String plate;
  VehicleType type = VehicleType.TRUCK;
  VehicleStatus status = VehicleStatus.IN_SERVICE;
  num odometerKm = 0.0; // <-- fix: double literal
  final _imeisCtrl = TextEditingController();
  final Set<String> capabilities = {};

  @override
  void initState() {
    super.initState();
    final v = widget.initial;
    plate = v?.plate ?? '';
    type = v?.type ?? VehicleType.TRUCK;
    status = v?.status ?? VehicleStatus.IN_SERVICE;
    odometerKm = v?.odometerKm ?? 0;
    _imeisCtrl.text = (v?.deviceImeis ?? []).join(', ');
    capabilities.addAll(v?.capabilities ?? []);
  }

  @override
  void dispose() {
    _imeisCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;
    const caps = [
      'REFRIGERATED',
      'BOX',
      'GPS_ONLY',
      'HEAVY_LOAD',
      'FRAGILE_CARGO',
    ];

    return AlertDialog(
      title: Text(isEdit ? 'Edit Vehicle' : 'Add Vehicle'),
      content: Form(
        key: _form,
        child: SizedBox(
          width: 560,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: plate,
                  decoration: const InputDecoration(labelText: 'Plate'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  onSaved: (v) => plate = v!.trim(),
                ),
                const SizedBox(height: 8),
                // ⚠️ usar initialValue en vez de value (deprecado)
                DropdownButtonFormField<VehicleType>(
                  // initialValue: type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: VehicleType.values
                      .map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(t.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => type = v ?? type),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<VehicleStatus>(
                  // initialValue: status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: VehicleStatus.values
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(_titleCase(s.name)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => status = v ?? status),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: odometerKm.toStringAsFixed(0),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Odometer (km)'),
                  onSaved: (v) => odometerKm = double.tryParse(v ?? '') ?? 0.0,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: -6,
                    children: caps.map((c) {
                      final sel = capabilities.contains(c);
                      return FilterChip(
                        label: Text(c),
                        selected: sel,
                        onSelected: (s) => setState(
                          () =>
                              s ? capabilities.add(c) : capabilities.remove(c),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _imeisCtrl,
                  decoration: const InputDecoration(
                    labelText: 'IoT Device IMEIs (comma or space separated)',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_form.currentState?.validate() != true) return;
            _form.currentState!.save();
            final imeis = _imeisCtrl.text
                .split(RegExp(r'[,\s]+'))
                .map((s) => s.trim())
                .where((s) => s.isNotEmpty)
                .toList();

            final v = Vehicle(
              id: widget.initial?.id,
              plate: plate,
              type: type,
              capabilities: capabilities.toList(),
              status: status,
              odometerKm: odometerKm,
              deviceImeis: imeis,
            );
            Navigator.pop(context, v);
          },
          child: Text(isEdit ? 'Update' : 'Create'),
        ),
      ],
    );
  }

  String _titleCase(String s) => s
      .split('_')
      .map((p) => p.isEmpty ? '' : '${p[0]}${p.substring(1).toLowerCase()}')
      .join(' ');
}
