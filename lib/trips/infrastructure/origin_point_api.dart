import 'package:cargasafe/trips/domain/model/origin_point.dart';
import 'package:cargasafe/trips/infrastructure/origin_point_assembler.dart';
import 'package:cargasafe/trips/infrastructure/origin_point_response.dart';
import 'package:dio/dio.dart';

class OriginPointApi {
  final Dio _dio;
  final String baseUrl;

  OriginPointApi(this._dio, this.baseUrl);

  Future<List<OriginPoint>> getOriginPoints() async {
    final res = await _dio.get('$baseUrl/origin-points');

    final resources = (res.data as List)
        .map((json) => OriginPointResponse.fromJson(json))
        .toList();

    return OriginPointAssembler.fromResources(resources);
  }

  Future<OriginPoint> getByTripId(int id) async {
    final res = await _dio.get('$baseUrl/origin-points?tripId=$id');

    final list = (res.data as List)
        .map((json) => OriginPointResponse.fromJson(json))
        .toList();

    return OriginPointAssembler.fromResource(list.first);
  }
}
