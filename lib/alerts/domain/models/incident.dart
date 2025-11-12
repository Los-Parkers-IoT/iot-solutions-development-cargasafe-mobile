class Incident {
  final int id;
  final int alertId;
  final String description;
  final DateTime createdAt;
  final DateTime? acknowledgedAt;
  final DateTime? closedAt;

  Incident({
    required this.id,
    required this.alertId,
    required this.description,
    required this.createdAt,
    this.acknowledgedAt,
    this.closedAt,
  });
}
