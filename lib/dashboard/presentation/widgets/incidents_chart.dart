import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../domain/entities/incidents_by_month.dart';


class IncidentsChart extends StatefulWidget {
  final List<IncidentsByMonth> incidents;

  const IncidentsChart({
    super.key,
    required this.incidents,
  });

  @override
  State<IncidentsChart> createState() => _IncidentsChartState();
}

class _IncidentsChartState extends State<IncidentsChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.incidents.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bar_chart, size: 48, color: AppColors.textSecondary),
                SizedBox(height: 16),
                Text(
                  'No incident data available',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _getMaxY(),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final incident = widget.incidents[groupIndex];
                        final value = rodIndex == 0
                            ? incident.temperatureIncidents
                            : incident.movementIncidents;
                        final type = rodIndex == 0 ? 'Temperature' : 'Movement';
                        return BarTooltipItem(
                          '$type\n$value incidents',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    touchCallback: (FlTouchEvent event, barTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            barTouchResponse == null ||
                            barTouchResponse.spot == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= widget.incidents.length) {
                            return const Text('');
                          }
                          final month = widget.incidents[value.toInt()].month;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              month.substring(0, 3),
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: _getMaxY() / 5,
                  ),
                  barGroups: _buildBarGroups(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  double _getMaxY() {
    double max = 0;
    for (var incident in widget.incidents) {
      if (incident.temperatureIncidents > max) {
        max = incident.temperatureIncidents.toDouble();
      }
      if (incident.movementIncidents > max) {
        max = incident.movementIncidents.toDouble();
      }
    }
    return (max * 1.2).ceilToDouble(); // Add 20% padding
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(widget.incidents.length, (index) {
      final incident = widget.incidents[index];
      final isTouched = index == touchedIndex;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: incident.temperatureIncidents.toDouble(),
            color: isTouched
                ? AppColors.temperatureBar.withValues(alpha: 0.8)
                : AppColors.temperatureBar,
            width: 12,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
          BarChartRodData(
            toY: incident.movementIncidents.toDouble(),
            color: isTouched
                ? AppColors.movementBar.withValues(alpha: 0.8)
                : AppColors.movementBar,
            width: 12,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    });
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(AppColors.temperatureBar, 'Temperature'),
        const SizedBox(width: 24),
        _buildLegendItem(AppColors.movementBar, 'Movement'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
