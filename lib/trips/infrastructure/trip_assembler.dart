import 'package:cargasafe/trips/domain/model/trip.dart';
import 'package:cargasafe/trips/domain/model/trip_status.dart';
import 'package:cargasafe/trips/infrastructure/trip_response.dart';

import 'origin_point_assembler.dart';
import 'delivery_order_assembler.dart';

class TripAssembler {
  static Trip fromResource(TripResource r) {
    return Trip(
      id: r.id,
      driverId: r.driverId,
      deviceId: r.deviceId,
      vehicleId: r.vehicleId,
      createdAt: DateTime.parse(r.createdAt),
      updatedAt: DateTime.parse(r.updatedAt),
      completedAt: r.completedAt != null
          ? DateTime.parse(r.completedAt!)
          : null,
      startedAt: r.startedAt != null ? DateTime.parse(r.startedAt!) : null,
      merchantId: r.merchantId,
      originPointId: r.originPoint.id,
      originPoint: OriginPointAssembler.fromResource(r.originPoint),
      deliveryOrders: r.deliveryOrders
          .map(DeliveryOrderAssembler.fromResource)
          .toList(),
      status: _parseStatus(r.status),
    );
  }

  static TripStatus _parseStatus(String s) {
    switch (s) {
      case 'CREATED':
        return TripStatus.created;
      case 'IN_PROGRESS':
        return TripStatus.inProgress;
      case 'COMPLETED':
        return TripStatus.completed;
      case 'CANCELLED':
        return TripStatus.cancelled;
      default:
        throw Exception("Unknown trip status: $s");
    }
  }

  static CreateTripResource toCreateResource(Trip entity) {
    return CreateTripResource(
      driverId: entity.driverId,
      deviceId: entity.deviceId,
      vehicleId: entity.vehicleId,
      merchantId: entity.merchantId,
      originPointId: entity.originPointId,
      deliveryOrders: entity.deliveryOrders.map((o) {
        return CreateTripDeliveryOrderResource(
          address: o.address,
          clientEmail: o.clientEmail,
          latitude: o.latitude,
          longitude: o.longitude,
          sequenceOrder: o.sequenceOrder,
          maxHumidity: o.maxHumidity,
          minHumidity: o.minHumidity,
          maxTemperature: o.maxTemperature,
          minTemperature: o.minTemperature,
          maxVibration: o.maxVibration,
        );
      }).toList(),
    );
  }
}
