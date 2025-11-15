class DeliveryOrderResponse {
  final int id;
  final int tripId;
  final String clientEmail;
  final int sequenceOrder;
  final String address;
  final double latitude;
  final double longitude;

  final double? maxHumidity;
  final double? minHumidity;
  final double? maxTemperature;
  final double? minTemperature;
  final double? maxVibration;

  final String? arrivalAt;
  final String createdAt;
  final String updatedAt;
  final String status;

  DeliveryOrderResponse({
    required this.id,
    required this.tripId,
    required this.clientEmail,
    required this.sequenceOrder,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.maxHumidity,
    required this.minHumidity,
    required this.maxTemperature,
    required this.minTemperature,
    required this.maxVibration,
    required this.arrivalAt,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory DeliveryOrderResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryOrderResponse(
      id: json['id'],
      tripId: json['tripId'],
      clientEmail: json['clientEmail'],
      sequenceOrder: json['sequenceOrder'],
      address: json['address'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      maxHumidity: (json['maxHumidity'] as num?)?.toDouble(),
      minHumidity: (json['minHumidity'] as num?)?.toDouble(),
      maxTemperature: (json['maxTemperature'] as num?)?.toDouble(),
      minTemperature: (json['minTemperature'] as num?)?.toDouble(),
      maxVibration: (json['maxVibration'] as num?)?.toDouble(),
      arrivalAt: json['arrivalAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
    );
  }
}
