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
