enum DeliveryOrderStatus {
  pending,
  inProgress,
  delivered,
  cancelled;

  String get value {
    switch (this) {
      case DeliveryOrderStatus.pending:
        return 'PENDING';
      case DeliveryOrderStatus.inProgress:
        return 'IN_PROGRESS';
      case DeliveryOrderStatus.delivered:
        return 'DELIVERED';
      case DeliveryOrderStatus.cancelled:
        return 'CANCELLED';
    }
  }

  static DeliveryOrderStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return DeliveryOrderStatus.pending;
      case 'IN_PROGRESS':
        return DeliveryOrderStatus.inProgress;
      case 'DELIVERED':
        return DeliveryOrderStatus.delivered;
      case 'CANCELLED':
        return DeliveryOrderStatus.cancelled;
      default:
        throw ArgumentError('Invalid DeliveryOrderStatus: $status');
    }
  }
}
