import 'trip.dart';
import 'delivery_order_status.dart';

class DeliveryOrder {
  int id;
  String clientEmail;
  String address;
  double latitude;
  double longitude;
  int sequenceOrder;
  DateTime? arrivalAt;
  String notes;

  double? maxHumidity;
  double? minHumidity;
  double? maxTemperature;
  double? minTemperature;
  double? maxVibration;

  int tripId;
  Trip? trip;
  DeliveryOrderStatus status;

  DeliveryOrder({
    required this.id,
    required this.clientEmail,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.sequenceOrder,
    required this.arrivalAt,
    required this.notes,
    required this.maxHumidity,
    required this.minHumidity,
    required this.maxTemperature,
    required this.minTemperature,
    required this.maxVibration,
    required this.tripId,
    required this.trip,
    required this.status,
  });

  /// --- FACTORY EMPTY ---
  factory DeliveryOrder.createEmpty() {
    return DeliveryOrder(
      id: 0,
      clientEmail: '',
      address: '',
      latitude: 0,
      longitude: 0,
      sequenceOrder: 0,
      arrivalAt: null,
      notes: '',
      maxHumidity: null,
      minHumidity: null,
      maxTemperature: null,
      minTemperature: null,
      maxVibration: null,
      tripId: 0,
      trip: null,
      status: DeliveryOrderStatus.pending,
    );
  }

  /// --- STATUS HELPERS ---
  bool isPending() => status == DeliveryOrderStatus.pending;
  bool isDelivered() => status == DeliveryOrderStatus.delivered;
  bool isCancelled() => status == DeliveryOrderStatus.cancelled;

  void markAsDelivered() {
    status = DeliveryOrderStatus.delivered;
  }
}
