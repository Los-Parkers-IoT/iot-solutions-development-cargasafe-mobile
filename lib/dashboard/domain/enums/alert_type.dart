enum AlertType {
  temperature('TEMPERATURE'),
  movement('MOVEMENT'),
  humidity('HUMIDITY'),
  doorOpen('DOOR_OPEN');

  final String value;
  const AlertType(this.value);

  static AlertType fromString(String value) {
    switch (value.toUpperCase()) {
      case 'TEMPERATURE':
        return AlertType.temperature;
      case 'MOVEMENT':
        return AlertType.movement;
      case 'HUMIDITY':
        return AlertType.humidity;
      case 'DOOR_OPEN':
      case 'DOOR OPEN':
      case 'DOOROPEN':
        return AlertType.doorOpen;
      default:
        return AlertType.temperature;
    }
  }
}

