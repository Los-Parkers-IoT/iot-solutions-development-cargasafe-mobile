import 'dart:io';
import 'package:dio/dio.dart';

abstract class BaseService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final Dio dio;

  BaseService({
    required this.baseUrl,
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  }) : dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           headers: const {
             'Content-Type': 'application/json',
             'Accept': 'application/json',
           },
           connectTimeout: Duration(seconds: 15),
           receiveTimeout: Duration(seconds: 15),
         ),
       );

  /// GET all
  Future<List<dynamic>> getAll({Map<String, String>? headers}) async {
    final response = await _sendRequest(
      dio.get('', options: Options(headers: {...defaultHeaders, ...?headers})),
    );
    return response as List<dynamic>;
  }

  /// POST
  Future<bool> post(Object requestBody, {Map<String, String>? headers}) async {
    await _sendRequest(
      dio.post(
        '',
        data: requestBody,
        options: Options(headers: {...defaultHeaders, ...?headers}),
      ),
    );
    return true;
  }

  /// PUT
  Future<bool> put(
    int id,
    Object requestBody, {
    Map<String, String>? headers,
  }) async {
    try {
      await _sendRequest(
        dio.put(
          '/$id',
          data: requestBody,
          options: Options(headers: {...defaultHeaders, ...?headers}),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// DELETE
  Future<bool> delete(int id, {Map<String, String>? headers}) async {
    try {
      await _sendRequest(
        dio.delete(
          '/$id',
          options: Options(headers: {...defaultHeaders, ...?headers}),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  /// GET by Id
  Future<dynamic> getById(String id, {Map<String, String>? headers}) async {
    return await _sendRequest(
      dio.get(
        '/$id',
        options: Options(headers: {...defaultHeaders, ...?headers}),
      ),
    );
  }

  /// Centralized request handling
  Future<dynamic> _sendRequest(Future<Response> request) async {
    try {
      final response = await request;

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response.data; // Dio ya decodifica JSON
      } else {
        throw HttpException(
          "Request failed with status: ${response.statusCode}",
          uri: Uri.parse(baseUrl),
        );
      }
    } on DioException catch (e) {
      // Manejo de errores más detallado
      throw HttpException("Dio error: ${e.message}", uri: e.requestOptions.uri);
    } catch (e) {
      rethrow;
    }
  }
}
