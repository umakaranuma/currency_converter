import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'env_config.dart';

// const int _defaultConsqnectTimeout = 50000;
// const int _defaultReceiveTimeout = 50000;

class ApiBaseRequsets {
  final String? baseUrl;
  final List<Interceptor>? interceptors;
  final String? token;
  final Dio? dio;
  late Dio _dio;
  ApiBaseRequsets({
    this.baseUrl,
    this.dio,
    this.interceptors,
    this.token,
  }) {
    _dio = dio ?? Dio();

    _dio
      ..options.baseUrl = baseUrl ?? AppConfig.apiUrl
      // ..options.connectTimeout = _defaultConnectTimeout
      // ..options.receiveTimeout = _defaultReceiveTimeout as Duration?
      ..httpClientAdapter
      ..options.headers = {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      };
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false));
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      String? token = await _getToken();
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      String? token = await _getToken();
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $token'
              },
            ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      String? token = await _getToken();
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      String? token = await _getToken();
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}),
        cancelToken: cancelToken,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postWifi(
    String uri, {
    data,
    String? btoken,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $btoken'
            }),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _getToken() async {
    // final dbProvider = DatabaseProvider.dbProvider;
    // final db = await dbProvider.database;
    // List<Map> users =
    //     await db.query(userTable, where: 'id = ?', whereArgs: [0]);
    // if (users.isNotEmpty) {
    //   return users[0]['token'];
    // } else {
    return null;
    // }
  }
}
