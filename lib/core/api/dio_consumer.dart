import 'dart:convert';
import 'dart:io';

import 'package:dio/io.dart';
import 'package:playstation/core/api/end_points.dart';
import 'package:playstation/core/api/app_interceptors.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:playstation/core/api/api_consumer.dart';
import 'package:playstation/core/api/status_code.dart';
import 'package:playstation/core/errors/exceptions.dart';
import 'package:playstation/injection_container.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio client;
  HttpClient httpClient = HttpClient();

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };
    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return jsonDecode(response.data.toString());
    } on DioException catch (err) {
      _handleDioError(err);
    }
  }

  @override
  Future post(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters, bool formDataIsEnabled = false}) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return jsonDecode(response.data.toString());
    } on DioException catch (err) {
      _handleDioError(err);
    }
  }

  @override
  Future patch(String path, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.patch(path, queryParameters: queryParameters, data: body);
      return jsonDecode(response.data.toString());
    } on DioException catch (err) {
      _handleDioError(err);
    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.badResponse:
        throw const BadRequestException();
      case DioExceptionType.connectionError:
        throw const FetchDataException();
      case DioExceptionType.badCertificate:
        throw const UnauthorizedException();
      case DioExceptionType.unknown:
        throw const UnauthorizedException();
      case DioExceptionType.sendTimeout:
        throw const BadRequestException();
      case DioExceptionType.receiveTimeout:
        throw const BadRequestException();
      case DioExceptionType.cancel:
        throw const BadRequestException();
    }
  }
}
