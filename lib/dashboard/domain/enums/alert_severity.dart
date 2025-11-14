enum AlertSeverity {
  low('LOW'),
  medium('MEDIUM'),
  high('HIGH'),
  critical('CRITICAL');

  final String value;
  const AlertSeverity(this.value);

  static AlertSeverity fromString(String value) {
    switch (value.toUpperCase()) {
      case 'LOW':
        return AlertSeverity.low;
      case 'MEDIUM':
        return AlertSeverity.medium;
      case 'HIGH':
        return AlertSeverity.high;
      case 'CRITICAL':
        return AlertSeverity.critical;
      default:
        return AlertSeverity.low;
    }
  }
}

