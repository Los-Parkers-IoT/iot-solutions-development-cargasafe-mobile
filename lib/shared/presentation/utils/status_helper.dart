import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../../../dashboard/domain/enums/trip_status.dart';
import '../../../dashboard/domain/enums/alert_severity.dart';

class StatusHelper {
  static Color getTripStatusColor(TripStatus status) {
    switch (status) {
      case TripStatus.inProgress:
        return AppColors.inProgress;
      case TripStatus.completed:
        return AppColors.completed;
      case TripStatus.delayed:
        return AppColors.delayed;
      case TripStatus.cancelled:
        return AppColors.cancelled;
      case TripStatus.planned:
        return AppColors.planned;
    }
  }

  static String getTripStatusText(TripStatus status) {
    switch (status) {
      case TripStatus.inProgress:
        return 'In Progress';
      case TripStatus.completed:
        return 'Completed';
      case TripStatus.delayed:
        return 'Delayed';
      case TripStatus.cancelled:
        return 'Cancelled';
      case TripStatus.planned:
        return 'Planned';
    }
  }

  static Color getAlertSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return AppColors.criticalAlert;
      case AlertSeverity.high:
        return AppColors.highAlert;
      case AlertSeverity.medium:
        return AppColors.mediumAlert;
      case AlertSeverity.low:
        return AppColors.lowAlert;
    }
  }

  static String getAlertSeverityText(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical:
        return 'Critical';
      case AlertSeverity.high:
        return 'High';
      case AlertSeverity.medium:
        return 'Medium';
      case AlertSeverity.low:
        return 'Low';
    }
  }
}

