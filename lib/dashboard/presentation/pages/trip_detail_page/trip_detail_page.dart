import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/utils/status_helper.dart';
import '../../../../shared/presentation/utils/date_formatter.dart';
import '../../../domain/entities/trip.dart';
import '../../../domain/entities/alert.dart';
import '../../providers/dashboard_provider.dart';

class TripDetailPage extends StatefulWidget {
  final String tripId;

  const TripDetailPage({
    Key? key,
    required this.tripId,
  }) : super(key: key);

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  Trip? _trip;
  List<Alert> _alerts = [];
  bool _isLoading = true;
  String? _error;
  String _sortBy = 'timestamp';
  String _filterBy = 'all';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final provider = context.read<DashboardProvider>();
      final trip = await provider.getTripById(widget.tripId);
      final alerts = await provider.getAlertsByTripId(widget.tripId);

      setState(() {
        _trip = trip;
        _alerts = alerts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<Alert> get _filteredAndSortedAlerts {
    var alerts = List<Alert>.from(_alerts);

    // Filter
    if (_filterBy != 'all') {
      if (_filterBy == 'resolved') {
        alerts = alerts.where((a) => a.resolved).toList();
      } else if (_filterBy == 'pending') {
        alerts = alerts.where((a) => !a.resolved).toList();
      } else if (_filterBy == 'critical') {
        alerts = alerts.where((a) => a.isCritical).toList();
      }
    }

    // Sort
    if (_sortBy == 'timestamp') {
      alerts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } else if (_sortBy == 'severity') {
      alerts.sort((a, b) => b.severity.index.compareTo(a.severity.index));
    }

    return alerts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorState()
              : _trip == null
                  ? _buildNotFoundState()
                  : _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTripInfo(),
          const SizedBox(height: 16),
          _buildMetrics(),
          const SizedBox(height: 24),
          _buildAlertsSection(),
        ],
      ),
    );
  }

  Widget _buildTripInfo() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _trip!.vehiclePlate,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                      color: StatusHelper.getTripStatusColor(_trip!.status)
                        .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    StatusHelper.getTripStatusText(_trip!.status),
                    style: TextStyle(
                      color: StatusHelper.getTripStatusColor(_trip!.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(Icons.person, 'Driver', _trip!.driverName),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.place, 'Origin', _trip!.origin),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, 'Destination', _trip!.destination),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.inventory_2, 'Cargo', _trip!.cargoType),
            const SizedBox(height: 12),
            _buildInfoRow(
              Icons.calendar_today,
              'Start Date',
              DateFormatter.formatDateTime(_trip!.startDate),
            ),
            if (_trip!.endDate != null) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.event_available,
                'End Date',
                DateFormatter.formatDateTime(_trip!.endDate!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
        children: [
          _buildMetricCard(
            icon: Icons.straighten,
            value: '${_trip!.distance.toStringAsFixed(1)} km',
            label: 'Distance',
          ),
          _buildMetricCard(
            icon: Icons.access_time,
            value: '${_trip!.getDurationInHours().toStringAsFixed(1)} h',
            label: 'Duration',
          ),
          _buildMetricCard(
            icon: Icons.speed,
            value: '${_trip!.getAverageSpeed().toStringAsFixed(0)} km/h',
            label: 'Avg Speed',
          ),
          _buildMetricCard(
            icon: Icons.warning_amber,
            value: '${_alerts.length}',
            label: 'Total Alerts',
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primaryOrange,
              size: 28,
            ),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alerts (${_alerts.length})',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                children: [
                  _buildFilterMenu(),
                  const SizedBox(width: 8),
                  _buildSortMenu(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildAlertsList(),
      ],
    );
  }

  Widget _buildFilterMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: (value) {
        setState(() {
          _filterBy = value;
        });
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'all', child: Text('All')),
        const PopupMenuItem(value: 'pending', child: Text('Pending')),
        const PopupMenuItem(value: 'resolved', child: Text('Resolved')),
        const PopupMenuItem(value: 'critical', child: Text('Critical')),
      ],
    );
  }

  Widget _buildSortMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.sort),
      onSelected: (value) {
        setState(() {
          _sortBy = value;
        });
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'timestamp', child: Text('By Time')),
        const PopupMenuItem(value: 'severity', child: Text('By Severity')),
      ],
    );
  }

  Widget _buildAlertsList() {
    final alerts = _filteredAndSortedAlerts;

    if (alerts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 64,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No alerts found',
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

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        return _buildAlertCard(alerts[index]);
      },
    );
  }

  Widget _buildAlertCard(Alert alert) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 8,
          decoration: BoxDecoration(
            color: StatusHelper.getAlertSeverityColor(alert.severity),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text(
          alert.type.value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(alert.location.address),
            Text(
              DateFormatter.formatDateTime(alert.timestamp),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: alert.resolved
            ? const Icon(Icons.check_circle, color: AppColors.completed)
            : const Icon(Icons.warning, color: AppColors.highAlert),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.criticalAlert,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error loading trip',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error ?? 'Unknown error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFoundState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              'Trip not found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

