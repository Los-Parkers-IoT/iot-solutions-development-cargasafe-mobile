import 'package:cargasafe/trips/infrastructure/delivery_order_response.dart';
import 'package:cargasafe/trips/infrastructure/origin_point_response.dart';

class TripResource {
  final int id;
  final int driverId;
  final int deviceId;
  final int vehicleId;
  final int merchantId;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? startedAt;
  final String? completedAt;
  final OriginPointResponse originPoint;
  final List<DeliveryOrderResponse> deliveryOrders;

  TripResource({
    required this.id,
    required this.driverId,
    required this.deviceId,
    required this.vehicleId,
    required this.merchantId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.startedAt,
    this.completedAt,
    required this.originPoint,
    required this.deliveryOrders,
  });

  factory TripResource.fromJson(Map<String, dynamic> json) {
    return TripResource(
      id: json['id'],
      driverId: json['driverId'],
      deviceId: json['deviceId'],
      vehicleId: json['vehicleId'],
      merchantId: json['merchantId'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      startedAt: json['startedAt'],
      completedAt: json['completedAt'],
      originPoint: OriginPointResponse.fromJson(json['originPoint']),
      deliveryOrders: (json['deliveryOrders'] as List)
          .map((x) => DeliveryOrderResponse.fromJson(x))
          .toList(),
    );
  }
}

class CreateTripResource {
  final int driverId;
  final int deviceId;
  final int vehicleId;
  final int merchantId;
  final int originPointId;
  final List<CreateTripDeliveryOrderResource> deliveryOrders;

  CreateTripResource({
    required this.driverId,
    required this.deviceId,
    required this.vehicleId,
    required this.merchantId,
    required this.originPointId,
    required this.deliveryOrders,
  });

  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId,
      'deviceId': deviceId,
      'vehicleId': vehicleId,
      'merchantId': merchantId,
      'originPointId': originPointId,
      'deliveryOrders': deliveryOrders.map((d) => d.toJson()).toList(),
    };
  }
}

class CreateTripDeliveryOrderResource {
  final String clientEmail;
  final String address;
  final double latitude;
  final double longitude;
  final int sequenceOrder;
  final double? maxHumidity;
  final double? minHumidity;
  final double? maxTemperature;
  final double? minTemperature;
  final double? maxVibration;

  CreateTripDeliveryOrderResource({
    required this.clientEmail,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.sequenceOrder,
    this.maxHumidity,
    this.minHumidity,
    this.maxTemperature,
    this.minTemperature,
    this.maxVibration,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientEmail': clientEmail,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'sequenceOrder': sequenceOrder,
      'maxHumidity': maxHumidity,
      'minHumidity': minHumidity,
      'maxTemperature': maxTemperature,
      'minTemperature': minTemperature,
      'maxVibration': maxVibration,
    };
  }
}
