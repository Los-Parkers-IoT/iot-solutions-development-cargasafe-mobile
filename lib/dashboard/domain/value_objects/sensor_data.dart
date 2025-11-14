class SensorData {
  final double? temperature;
  final double? movement;
  final double? humidity;
  final bool? door;
  final DateTime timestamp;

  SensorData({
    this.temperature,
    this.movement,
    this.humidity,
    this.door,
    required this.timestamp,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    // Manejar diferentes estructuras de sensorData según el tipo de alerta
    double? temperature;
    double? movement;
    double? humidity;
    bool? door;

    // Temperatura - puede venir directo o dentro de un objeto
    if (json['temperature'] != null) {
      if (json['temperature'] is num) {
        temperature = (json['temperature'] as num).toDouble();
      }
    }

    // Movement - viene dentro de un objeto anidado
    if (json['movement'] != null && json['movement'] is Map) {
      final movementData = json['movement'] as Map<String, dynamic>;
      if (movementData['intensity'] != null) {
        movement = (movementData['intensity'] as num).toDouble();
      }
    }

    // Humidity - puede venir directo o dentro de un objeto
    if (json['humidity'] != null) {
      if (json['humidity'] is num) {
        humidity = (json['humidity'] as num).toDouble();
      }
    }

    // Door - viene dentro de un objeto anidado
    if (json['door'] != null && json['door'] is Map) {
      final doorData = json['door'] as Map<String, dynamic>;
      if (doorData['status'] != null) {
        door = doorData['status'].toString().toUpperCase() == 'OPEN';
      }
    }

    return SensorData(
      temperature: temperature,
      movement: movement,
      humidity: humidity,
      door: door,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'movement': movement,
      'humidity': humidity,
      'door': door,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  SensorData copyWith({
    double? temperature,
    double? movement,
    double? humidity,
    bool? door,
    DateTime? timestamp,
  }) {
    return SensorData(
      temperature: temperature ?? this.temperature,
      movement: movement ?? this.movement,
      humidity: humidity ?? this.humidity,
      door: door ?? this.door,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
class Location {
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  Location copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return Location(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}

