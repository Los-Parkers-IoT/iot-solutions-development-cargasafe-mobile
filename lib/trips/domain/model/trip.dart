import 'package:cargasafe/dashboard/domain/enums/trip_status.dart';
import 'package:cargasafe/trips/domain/model/delivery_order.dart';
import 'package:cargasafe/trips/domain/model/origin_point.dart';

class Trip {
  int id;
  int driverId;
  int deviceId;
  int vehicleId;

  DateTime createdAt;
  DateTime updatedAt;

  int merchantId;
  int originPointId;

  DateTime? startedAt;
  DateTime? completedAt;

  OriginPoint? originPoint;
  List<DeliveryOrder> deliveryOrders;
  TripStatus status;

  Trip({
    required this.id,
    required this.driverId,
    required this.vehicleId,
    required this.deviceId,
    required this.merchantId,
    required this.originPointId,
    this.originPoint,
    List<DeliveryOrder>? deliveryOrders,
    required this.startedAt,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  }) : deliveryOrders = deliveryOrders ?? [];

  /// --- STATIC FACTORY ---
  factory Trip.createEmpty() {
    final now = DateTime.now();
    return Trip(
      id: 0,
      driverId: 0,
      vehicleId: 0,
      deviceId: 0,
      merchantId: 0,
      originPointId: 0,
      startedAt: null,
      completedAt: null,
      createdAt: now,
      updatedAt: now,
      status: TripStatus.created,
    );
  }

  /// --- STATUS HELPERS ---
  bool isCompleted() => status == TripStatus.completed;
  bool isInProgress() => status == TripStatus.inProgress;
  bool isCreated() => status == TripStatus.created;
}
