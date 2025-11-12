import 'package:equatable/equatable.dart';
import 'package:cargasafe/alerts/domain/models/alert.dart';

enum AlertStatus { initial, loading, success, failure }

class AlertState extends Equatable {
  final AlertStatus status;
  final List<Alert> alerts;
  final String? errorMessage;

  const AlertState({
    this.status = AlertStatus.initial,
    this.alerts = const [],
    this.errorMessage,
  });

  AlertState copyWith({
    AlertStatus? status,
    List<Alert>? alerts,
    String? errorMessage,
  }) {
    return AlertState(
      status: status ?? this.status,
      alerts: alerts ?? this.alerts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, alerts, errorMessage];
}
