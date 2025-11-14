import 'package:flutter_bloc/flutter_bloc.dart';
import 'alert_event.dart';
import 'alert_state.dart';
import 'package:cargasafe/alerts/infrastructure/alert_api.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final AlertsApi api;

  AlertBloc(this.api) : super(const AlertState()) {
    on<LoadAlerts>(_onLoadAlerts);
    on<AcknowledgeAlert>(_onAcknowledgeAlert);
    on<CloseAlert>(_onCloseAlert);
  }

  Future<void> _onLoadAlerts(
      LoadAlerts event, Emitter<AlertState> emit) async {
    emit(state.copyWith(status: AlertStatus.loading));
    try {
      final alerts = await api.getAlerts();
      emit(state.copyWith(status: AlertStatus.success, alerts: alerts));
    } catch (e) {
      emit(state.copyWith(status: AlertStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onAcknowledgeAlert(
      AcknowledgeAlert event, Emitter<AlertState> emit) async {
    try {
      final updated = await api.acknowledgeAlert(event.id);
      final updatedList = state.alerts.map((a) =>
      a.id == updated.id ? updated : a).toList();
      emit(state.copyWith(alerts: updatedList));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onCloseAlert(
      CloseAlert event, Emitter<AlertState> emit) async {
    try {
      final updated = await api.closeAlert(event.id);
      final updatedList = state.alerts.map((a) =>
      a.id == updated.id ? updated : a).toList();
      emit(state.copyWith(alerts: updatedList));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
