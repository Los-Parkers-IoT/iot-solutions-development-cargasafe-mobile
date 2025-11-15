class IncidentsByMonth {
  final String id;
  final String month;
  final int year;
  final int temperatureIncidents;
  final int movementIncidents;
  final int totalIncidents;

  IncidentsByMonth({
    required this.id,
    required this.month,
    required this.year,
    required this.temperatureIncidents,
    required this.movementIncidents,
    required this.totalIncidents,
  });

  IncidentsByMonth copyWith({
    String? id,
    String? month,
    int? year,
    int? temperatureIncidents,
    int? movementIncidents,
    int? totalIncidents,
  }) {
    return IncidentsByMonth(
      id: id ?? this.id,
      month: month ?? this.month,
      year: year ?? this.year,
      temperatureIncidents: temperatureIncidents ?? this.temperatureIncidents,
      movementIncidents: movementIncidents ?? this.movementIncidents,
      totalIncidents: totalIncidents ?? this.totalIncidents,
    );
  }
}

