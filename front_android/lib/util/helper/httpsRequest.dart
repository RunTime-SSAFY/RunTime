import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final api = Dio(
  BaseOptions(
    baseUrl: dotenv.get('BASE_URL'),
  ),
);

final interceptors = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return handler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return handler.next(response);
  },
  onError: (DioException error, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
    return handler.next(error);
  },
);
