import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/util/route_path.dart';

final apiInstance = Dio(
  BaseOptions(
    baseUrl: dotenv.get('BASE_URL'),
  ),
);

class CustomInterceptor extends Interceptor {
  final BuildContext context;
  final AuthService authService;

  CustomInterceptor({
    required this.context,
    required this.authService,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = authService.accessToken;
    options.headers['Authorization'] = 'Bearer $accessToken';

    debugPrint('요청\nREQUEST[${options.method}] => PATH: ${options.path}');
    debugPrint('요청 데이터\n${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
        '응답\nRESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('에러 $err');
    if (err.response?.statusCode == 401) {
      Navigator.of(context).pushNamed(RoutePath.login);
    } else {
      super.onError(err, handler);
    }
  }
}
