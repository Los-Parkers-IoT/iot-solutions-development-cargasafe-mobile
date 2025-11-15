import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cargasafe/alerts/application/alert_bloc.dart';
import 'package:cargasafe/alerts/application/alert_event.dart';
import 'package:cargasafe/alerts/application/alert_state.dart';
import '../../widgets/alerts_card.dart';
import '../../widgets/alert_table.dart';
import 'package:cargasafe/alerts/infrastructure/alert_api.dart';

class AlertsView extends StatelessWidget {
  const AlertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlertBloc(AlertsApi())..add(LoadAlerts()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Alerts')),
        body: BlocBuilder<AlertBloc, AlertState>(
          builder: (context, state) {
            if (state.status == AlertStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == AlertStatus.failure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            final activeCount =
                state.alerts.where((a) => a.alertStatus == 'OPEN').length;
            final closedCount =
                state.alerts.where((a) => a.alertStatus == 'CLOSED').length;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AlertCard(
                          count: '$activeCount',
                          label: 'Active',
                          isDanger: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AlertCard(
                          count: '$closedCount',
                          label: 'Closed',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: AlertTable(alerts: state.alerts),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
