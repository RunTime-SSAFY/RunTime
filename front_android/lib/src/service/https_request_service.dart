import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front_android/src/service/atuh_service.dart';
import 'package:front_android/util/route_path.dart';

final api = Dio(
  BaseOptions(
    baseUrl: dotenv.get('BASE_URL'),
  ),
);

class CustomInterceptor extends Interceptor {
  CustomInterceptor({
    required this.context,
    required this.authService,
  });

  final BuildContext context;
  final AuthService authService;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = authService.accessToken;
    options.headers['Authorization'] = 'Bearer $accessToken';

    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Navigator.of(context).pushNamed(RoutePath.login);
    } else {
      super.onError(err, handler);
    }
  }
}
