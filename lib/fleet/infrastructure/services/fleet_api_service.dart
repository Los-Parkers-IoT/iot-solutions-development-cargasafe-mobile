import 'package:dio/dio.dart';
import 'package:cargasafe/shared/core/app_config.dart';
import 'endpoints.dart';

class FleetApiService {
  FleetApiService({String? baseUrl})
      : _baseUrl = baseUrl ?? AppConfig.baseUrl,
        _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? AppConfig.baseUrl,
            connectTimeout: Duration(milliseconds: AppConfig.connectTimeoutMs),
            receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeoutMs),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TODO: si tienes token en SharedPreferences, agrégalo aquí.
        // final token = await SharedPreferencesService.instance.getToken();
        // if (token != null && token.isNotEmpty) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        return handler.next(options);
      },
    ));
  }

  final String _baseUrl;
  final Dio _dio;

  /// Lo que esperan tus datasources:
  Dio get client => _dio;
  FleetEndpoints get ep => FleetEndpoints(_baseUrl);

  // (Opcionales si los quieres usar directo)
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) =>
      _dio.get<T>(path, queryParameters: query);
  Future<Response<T>> post<T>(String path, {dynamic body}) => _dio.post<T>(path, data: body);
  Future<Response<T>> patch<T>(String path, {dynamic body}) => _dio.patch<T>(path, data: body);
  Future<Response<T>> put<T>(String path, {dynamic body}) => _dio.put<T>(path, data: body);
  Future<Response<T>> deleteReq<T>(String path) => _dio.delete<T>(path);
}
