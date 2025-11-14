import 'package:cargasafe/shared/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cargasafe/alerts/presentation/widgets/alerts_card.dart';
import 'package:cargasafe/alerts/presentation/widgets/alert_table.dart';
import 'package:cargasafe/alerts/application/alert_bloc.dart';
import 'package:cargasafe/alerts/application/alert_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cargasafe/shared/presentation/theme/app_colors.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Alerts',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            Expanded(
              child: BlocBuilder<AlertBloc, AlertState>(
                builder: (context, state) {
                  return AlertTable(
                    alerts: state.alerts, 
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}