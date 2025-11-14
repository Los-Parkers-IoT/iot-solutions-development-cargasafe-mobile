import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cargasafe/alerts/domain/models/alert.dart';
import 'package:cargasafe/alerts/application/alert_bloc.dart';
import 'package:cargasafe/alerts/application/alert_event.dart';

class AlertTable extends StatelessWidget {
  final List<Alert> alerts;
  const AlertTable({super.key, required this.alerts});

  void _showDetailsDialog(BuildContext context, Alert alert) {
    if (alert.alertStatus == 'OPEN') {
      context.read<AlertBloc>().add(AcknowledgeAlert(alert.id));
    }

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Alert details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Type: ${alert.alertType}"),
                Text("Status: ${alert.alertStatus}"),
                const SizedBox(height: 8),
                if (alert.description.isNotEmpty)
                  Text("Description: ${alert.description}"),
                Text("Created: ${alert.createdAt}"),
                if (alert.closedAt != null)
                  Text("Closed: ${alert.closedAt}"),
                const SizedBox(height: 12),
                if (alert.incidents.isNotEmpty) ...[
                  const Text(
                    "Incidents:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  for (var i in alert.incidents)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text("- ${i.description}"),
                    ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Created')),
            DataColumn(label: Text('Actions')),
          ],
          rows: alerts.map((alert) {
            return DataRow(cells: [
              DataCell(Text(alert.id.toString())),
              DataCell(Text(alert.alertType)),
              DataCell(Text(alert.alertStatus)),
              DataCell(Text(alert.createdAt.toString())),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.blue),
                    tooltip: "View details",
                    onPressed: () => _showDetailsDialog(context, alert),
                  ),

                  if (alert.alertStatus != 'CLOSED')
                    TextButton(
                      onPressed: () {
                        context
                            .read<AlertBloc>()
                            .add(CloseAlert(alert.id));
                      },
                      child: const Text('Mark as Resolved'),
                    ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
