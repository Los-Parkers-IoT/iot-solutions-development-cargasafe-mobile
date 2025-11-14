import 'package:flutter/material.dart';

class AlertTable extends StatelessWidget {
  const AlertTable({super.key});

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
            DataColumn(label: Text('Delivery Order ID')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Created')),
            DataColumn(label: Text('Closed')),
            DataColumn(label: Text('Actions')),
            DataColumn(label: Text('Details')),
          ],
          rows: const [],
        ),
      ),
    );
  }
}