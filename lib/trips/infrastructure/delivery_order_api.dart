import 'package:cargasafe/shared/core/app_config.dart';
import 'package:cargasafe/trips/domain/model/delivery_order.dart';
import 'package:dio/dio.dart';
import 'delivery_order_assembler.dart';
import 'delivery_order_response.dart';

class DeliveryOrdersApi {
  // Cambia la URL base cuando quieras (no en constructor)
  final String baseUrl = AppConfig.baseUrl;
  final String endpoint = "/delivery-orders";

  late final Dio _dio;

  DeliveryOrdersApi() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  String get _full => endpoint;

  // ----------------------------------------------------
  // GET ALL DELIVERY ORDERS
  // ----------------------------------------------------
  Future<List<DeliveryOrder>> getAll() async {
    final response = await _dio.get(_full);

    final list = (response.data as List)
        .map((json) => DeliveryOrderResponse.fromJson(json))
        .toList();

    return list.map(DeliveryOrderAssembler.fromResource).toList();
  }

  // ----------------------------------------------------
  // MARK AS DELIVERED
  // ----------------------------------------------------
  Future<void> markAsDelivered(int orderId) async {
    await _dio.post("$_full/$orderId/delivery");
  }
}

class DeliveryOrderResource {}
