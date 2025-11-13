import 'package:cargasafe/shared/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../providers/dashboard_provider.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/trip_card.dart';
import '../../widgets/incidents_chart.dart';
import '../trip_detail_page/trip_detail_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardProvider = context.read<DashboardProvider>();
      dashboardProvider.loadDashboardData();
    });
  }


  Future<void> _refreshData() async {
    await context.read<DashboardProvider>().loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AppScaffold(
      title: 'Dashboard',
      body: Consumer<DashboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.trips.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null && provider.trips.isEmpty) {
            return _buildErrorState(provider.error!);
          }

          return RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildKPICards(provider),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Monthly Incidents'),
                  IncidentsChart(incidents: provider.incidents),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Recent Trips'),
                  _buildTripsList(provider),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKPICards(DashboardProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
        children: [
          StatCard(
            title: 'Total Trips',
            value: provider.totalTrips.toString(),
            icon: Icons.route,
            iconColor: AppColors.primaryOrange,
          ),
          StatCard(
            title: 'Active Trips',
            value: provider.activeTrips.toString(),
            icon: Icons.local_shipping,
            iconColor: AppColors.inProgress,
          ),
          StatCard(
            title: 'Total Alerts',
            value: provider.totalAlerts.toString(),
            icon: Icons.warning_amber,
            iconColor: AppColors.highAlert,
          ),
          StatCard(
            title: 'Pending Alerts',
            value: provider.pendingAlerts.toString(),
            icon: Icons.notification_important,
            iconColor: AppColors.criticalAlert,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildTripsList(DashboardProvider provider) {
    final recentTrips = provider.trips.take(3).toList();

    if (recentTrips.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.route_outlined,
                size: 64,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No trips available',
                style: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: recentTrips.map((trip) {
        return TripCard(
          trip: trip,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TripDetailPage(tripId: trip.id),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.criticalAlert,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading dashboard',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _refreshData,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
