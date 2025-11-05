import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cargasafe/alerts/presentation/widgets/alerts_card.dart';
import 'package:cargasafe/alerts/presentation/widgets/alert_table.dart';
import 'package:cargasafe/shared/presentation/theme/app_colors.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        centerTitle: false,
      ),
      drawer: _buildDrawer(context),
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryOrange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.local_shipping,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  'CargaSafe',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              context.go('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('Vehicles'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Vehicles
            },
          ),
          ListTile(
            leading: const Icon(Icons.sensors),
            title: const Text('Sensors'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Sensors
            },
          ),
          ListTile(
            leading: const Icon(Icons.route),
            title: const Text('Trips'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Trips
            },
          ),
          ListTile(
            leading: const Icon(Icons.warning, color: AppColors.primaryOrange),
            title: const Text('Alerts'),
            selected: true,
            selectedTileColor: AppColors.primaryOrange.withOpacity(0.1),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions),
            title: const Text('Subscriptions'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to Subscriptions
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement logout
            },
          ),
        ],
      ),
    );
  }
}