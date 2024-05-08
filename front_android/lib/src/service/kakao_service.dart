import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:front_android/src/repository/secure_storage_repository.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

interface class KakaoService {
  static Future<OAuthToken> _loginWithKakaoTalk({
    List<String>? channelPublicIds,
    List<String>? serviceTerms,
    String? nonce,
  }) async {
    var codeVerifier = AuthCodeClient.codeVerifier();

    String? stateToken;
    String? redirectUrl;
    if (kIsWeb) {
      stateToken = generateRandomString(20);
      redirectUrl = await AuthCodeClient.instance.platformRedirectUri();
    }

    final authCode = await AuthCodeClient.instance.authorizeWithTalk(
      redirectUri: redirectUrl ?? KakaoSdk.redirectUri,
      channelPublicId: channelPublicIds,
      serviceTerms: serviceTerms,
      codeVerifier: codeVerifier,
      nonce: nonce,
      stateToken: stateToken,
      webPopupLogin: true,
    );

    final token = await AuthApi.instance.issueAccessToken(
        redirectUri: redirectUrl,
        authCode: authCode,
        codeVerifier: codeVerifier);
    await TokenManagerProvider.instance.manager.setToken(token);
    return token;
  }

  static Future<OAuthToken> _loginWithKakaoAccount({
    List<Prompt>? prompts,
    List<String>? channelPublicIds,
    List<String>? serviceTerms,
    String? loginHint,
    String? nonce,
  }) async {
    String codeVerifier = AuthCodeClient.codeVerifier();
    final authCode = await AuthCodeClient.instance.authorize(
      redirectUri: KakaoSdk.redirectUri,
      prompts: prompts,
      channelPublicIds: channelPublicIds,
      serviceTerms: serviceTerms,
      codeVerifier: codeVerifier,
      loginHint: loginHint,
      nonce: nonce,
      webPopupLogin: true,
    );
    final token = await AuthApi.instance
        .issueAccessToken(authCode: authCode, codeVerifier: codeVerifier);
    await TokenManagerProvider.instance.manager.setToken(token);
    return token;
  }

  static _saveToken(Map<String, dynamic> json) async {
    var accessToken = json['accessToken'];
    var refreshToken = json['refreshToken'];
    assert(accessToken != null, 'accessToken 없음');
    assert(refreshToken != null, 'refreshToken 없음');
    await SecureStorageRepository.instance.setAccessToken(accessToken);
    await SecureStorageRepository.instance.setRefreshToken(refreshToken);
    await AuthService.instance.setAccessToken(accessToken);
    await AuthService.instance.setRefreshToken(refreshToken);
  }

  static Future<String> _getOurToken(OAuthToken token) async {
    try {
      User user = await UserApi.instance.me();
      var response = await noAuthApi.post(
        'api/auth/login',
        data: {
          "email": user.kakaoAccount?.email,
        },
      );
      if (user.kakaoAccount?.email != null) {
        UserService.instance.email = user.kakaoAccount!.email!;
      }

      var ourToken = response.data;
      await _saveToken(ourToken);
      await UserService.instance.getUserInfor();
      return response.data.toString();
    } catch (error) {
      debugPrint(error.toString());
      debugPrint((error as DioException).response?.data.toString());
      rethrow;
    }
  }

  static Future<String> kakaoLogin() async {
    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        var token = await _loginWithKakaoTalk();
        return _getOurToken(token);
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          throw error.toString();
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          var token = await _loginWithKakaoAccount();
          return _getOurToken(token);
        } catch (error) {
          throw error.toString();
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        return _getOurToken(token);
      } catch (error) {
        throw error.toString();
      }
    }
  }
}
