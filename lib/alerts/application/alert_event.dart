import 'package:equatable/equatable.dart';

abstract class AlertEvent extends Equatable {
  const AlertEvent();

  @override
  List<Object?> get props => [];
}

class LoadAlerts extends AlertEvent {}
class AcknowledgeAlert extends AlertEvent {
  final int id;
  const AcknowledgeAlert(this.id);
}
class CloseAlert extends AlertEvent {
  final int id;
  const CloseAlert(this.id);
}
