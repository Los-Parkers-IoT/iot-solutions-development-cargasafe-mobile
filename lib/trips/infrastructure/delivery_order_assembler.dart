import 'package:cargasafe/trips/domain/model/delivery_order.dart';
import 'package:cargasafe/trips/domain/model/delivery_order_status.dart';
import 'package:cargasafe/trips/infrastructure/delivery_order_response.dart';

class DeliveryOrderAssembler {
  static List<DeliveryOrder> fromResources(
    List<DeliveryOrderResponse> resources,
  ) {
    return resources.map(fromResource).toList();
  }

  static DeliveryOrder fromResource(DeliveryOrderResponse r) {
    return DeliveryOrder(
      id: r.id,
      clientEmail: r.clientEmail,
      address: r.address,
      latitude: r.latitude,
      longitude: r.longitude,
      sequenceOrder: r.sequenceOrder,
      arrivalAt: r.arrivalAt != null ? DateTime.parse(r.arrivalAt!) : null,
      notes: "", // igual que en TS
      maxHumidity: r.maxHumidity,
      minHumidity: r.minHumidity,
      maxTemperature: r.maxTemperature,
      minTemperature: r.minTemperature,
      maxVibration: r.maxVibration,
      tripId: r.tripId,
      trip: null,
      status: _parseStatus(r.status),
    );
  }

  static DeliveryOrderStatus _parseStatus(String s) {
    switch (s.toUpperCase()) {
      case 'PENDING':
        return DeliveryOrderStatus.pending;
      case 'IN_PROGRESS':
        return DeliveryOrderStatus.inProgress;
      case 'DELIVERED':
        return DeliveryOrderStatus.delivered;
      case 'CANCELLED':
        return DeliveryOrderStatus.cancelled;
      default:
        throw Exception("Unknown delivery order status: $s");
    }
  }
}
