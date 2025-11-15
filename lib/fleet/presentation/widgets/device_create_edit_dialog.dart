import 'package:flutter/material.dart';
import '../../domain/entities/device.dart';

class DeviceCreateEditDialog extends StatefulWidget {
  const DeviceCreateEditDialog({
    super.key,
    this.initial,
  });

  final Device? initial;

  static Future<Device?> show(BuildContext context, {Device? initial}) {
    return showDialog<Device>(
      context: context,
      builder: (_) => DeviceCreateEditDialog(initial: initial),
    );
  }

  @override
  State<DeviceCreateEditDialog> createState() => _DeviceCreateEditDialogState();
}

class _DeviceCreateEditDialogState extends State<DeviceCreateEditDialog> {
  final _form = GlobalKey<FormState>();
  late String imei;
  late String firmware;
  bool online = false;
  String? vehiclePlate;

  @override
  void initState() {
    super.initState();
    imei = widget.initial?.imei ?? '';
    firmware = widget.initial?.firmware ?? 'v1.0.0';
    online = widget.initial?.online ?? false;
    vehiclePlate = widget.initial?.vehiclePlate;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;
    return AlertDialog(
      title: Text(isEdit ? 'Edit Device' : 'Register Device'),
      content: Form(
        key: _form,
        child: SizedBox(
          width: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: imei,
                decoration: const InputDecoration(labelText: 'IMEI'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                onSaved: (v) => imei = v!.trim(),
              ),
              TextFormField(
                initialValue: firmware,
                decoration: const InputDecoration(labelText: 'Firmware'),
                onSaved: (v) => firmware = v!.trim(),
              ),
              TextFormField(
                initialValue: vehiclePlate ?? '',
                decoration: const InputDecoration(labelText: 'Vehicle plate (optional)'),
                onSaved: (v) => vehiclePlate = (v?.trim().isEmpty ?? true) ? null : v!.trim(),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Online'),
                value: online,
                onChanged: (b) => setState(() => online = b),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            if (_form.currentState?.validate() != true) return;
            _form.currentState!.save();
            final result = Device(
              id: widget.initial?.id,
              imei: imei,
              firmware: firmware,
              online: online,
              vehiclePlate: vehiclePlate,
            );
            Navigator.pop(context, result);
          },
          child: Text(isEdit ? 'Update' : 'Create'),
        )
      ],
    );
  }
}
