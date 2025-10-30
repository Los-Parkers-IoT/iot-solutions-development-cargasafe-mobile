import 'package:flutter/material.dart';
import 'package:cargasafe/alerts/presentation/widgets/alerts_card.dart';
import 'package:cargasafe/alerts/presentation/widgets/alert_table.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards resumen
            Row(
              children: const [
                Expanded(
                  child: AlertCard(
                    count: '0',
                    label: 'Alerts today',
                    isDanger: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AlertCard(
                    count: '0',
                    label: 'Resolved',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search alerts',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: null,
                    decoration: InputDecoration(
                      hintText: 'Status',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'active', child: Text('Active')),
                      DropdownMenuItem(value: 'closed', child: Text('Closed')),
                    ],
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Tabla
            const Expanded(child: AlertTable()),
          ],
        ),
      ),
    );
  }
}