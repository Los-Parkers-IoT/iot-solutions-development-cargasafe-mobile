class OriginPointResponse {
  final int id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  OriginPointResponse({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  factory OriginPointResponse.fromJson(Map<String, dynamic> json) {
    return OriginPointResponse(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}
