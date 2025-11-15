enum TripStatus {
  created,
  inProgress,
  completed,
  cancelled;

  String get value {
    switch (this) {
      case TripStatus.created:
        return 'CREATED';
      case TripStatus.inProgress:
        return 'IN_PROGRESS';
      case TripStatus.completed:
        return 'COMPLETED';
      case TripStatus.cancelled:
        return 'CANCELLED';
    }
  }

  static TripStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'CREATED':
        return TripStatus.created;
      case 'IN_PROGRESS':
        return TripStatus.inProgress;
      case 'COMPLETED':
        return TripStatus.completed;
      case 'CANCELLED':
        return TripStatus.cancelled;
      default:
        throw ArgumentError('Invalid TripStatus: $status');
    }
  }
}
