enum TripStatus {
  inProgress('IN_PROGRESS'),
  completed('COMPLETED'),
  cancelled('CANCELLED'),
  delayed('DELAYED'),
  planned('PLANNED');

  final String value;
  const TripStatus(this.value);

  static TripStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'IN_PROGRESS':
      case 'IN PROGRESS':
      case 'INPROGRESS':
        return TripStatus.inProgress;
      case 'COMPLETED':
        return TripStatus.completed;
      case 'CANCELLED':
        return TripStatus.cancelled;
      case 'DELAYED':
        return TripStatus.delayed;
      case 'PLANNED':
        return TripStatus.planned;
      default:
        return TripStatus.planned;
    }
  }
}

