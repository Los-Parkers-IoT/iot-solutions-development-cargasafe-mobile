import 'package:flutter/material.dart';
import 'package:cargasafe/alerts/domain/models/alert.dart';
import 'package:cargasafe/alerts/application/alert_bloc.dart';
import 'package:cargasafe/alerts/application/alert_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertTable extends StatelessWidget {
  final List<Alert> alerts;
  const AlertTable({super.key, required this.alerts});

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
                  if (alert.alertStatus != 'CLOSED')
                    TextButton(
                      onPressed: () => context.read<AlertBloc>().add(CloseAlert(alert.id)),
                      child: const Text('Close'),
                    ),
                  if (alert.alertStatus == 'OPEN')
                    TextButton(
                      onPressed: () => context.read<AlertBloc>().add(AcknowledgeAlert(alert.id)),
                      child: const Text('Acknowledge'),
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
