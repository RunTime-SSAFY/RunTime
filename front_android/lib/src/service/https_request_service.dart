import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front_android/src/repository/secure_storage_repository.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/router.dart';

final apiInstance = Dio(
  BaseOptions(
    baseUrl: dotenv.get('BASE_URL'),
  ),
);

class CustomInterceptor extends Interceptor {
  final AuthService authService;

  CustomInterceptor({
    required this.authService,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = authService.accessToken;
    options.headers['Authorization'] = 'Bearer $accessToken';

    debugPrint(
        '--------요청--------\nREQUEST[${options.method}] => PATH: ${options.uri.toString()}');
    debugPrint('쿼리 파라미터 ${options.queryParameters}');
    debugPrint('요청 데이터 ${options.data.toString()}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
        '--------응답--------\nRESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    debugPrint('응답 데이터 ${response.data.toString()}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('에러 $err');

    if (err.response?.statusCode == 401) {
      final originalRequest = err.requestOptions;
      try {
        // 원래 요청에 새 토큰 설정
        var response = await getNewAccessToken();
        originalRequest.headers['Authorization'] =
            'Bearer ${response.data['accessToken']}';
        var newResponse = await noAuthApi.fetch(originalRequest);
        return handler.resolve(newResponse);
      } catch (error) {
        debugPrint('토큰 재발급 실패: $error');
        AuthService.instance.setRefreshToken(null);
        await SecureStorageRepository.instance.setAccessToken(null);
        // 나중에 확인 필수
        router.go(RoutePathHelper.login);
      }
    } else {
      debugPrint('에러 메세지 ${err.message}');
      super.onError(err, handler);
    }
  }
}

final noAuthApi = Dio(BaseOptions(baseUrl: dotenv.get('BASE_URL')));

Future<Response> getNewAccessToken() async {
  try {
    debugPrint('refreshToken 요청');
    var response = await noAuthApi.post(
      'api/auth/reissue',
      options: Options(
        headers: {
          'refreshToken': AuthService.instance.refreshToken,
        },
      ),
    );
    await AuthService.instance.setAccessToken(response.data['accessToken']);
    await AuthService.instance.setRefreshToken(response.data['refreshToken']);
    return response;
  } catch (error) {
    print('엑세스 토큰 발급 오류 $error');
    rethrow;
  }
}

class CustomInterceptorForNoAuth extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint(
        '--------noAuth 요청--------\nREQUEST[${options.method}] => PATH: ${options.uri.toString()}');
    debugPrint('쿼리 파라미터 ${options.queryParameters}');
    debugPrint('요청 데이터 ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
        '--------noAuth 응답--------\nRESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('noAuth $err');
    super.onError(err, handler);
  }
}
