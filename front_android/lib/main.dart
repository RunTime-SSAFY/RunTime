import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/router.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Kakao SDK
  KakaoSdk.init(
    nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"),
    javaScriptAppKey: dotenv.get("KAKAO_JAVASCRIPT_KEY"),
  );

  // 기기에 저장된 토큰 불러오기
  await AuthService.instance.init();

  // 인터셉터
  apiInstance.interceptors.add(CustomInterceptor(
    authService: AuthService.instance,
  ));
  noAuthApi.interceptors.add(CustomInterceptorForNoAuth());

  // refreshToken이 있는지 확인
  // try {
  //   final refreshToken = await SecureStorageRepository.instance.refreshToken;
  //   if (refreshToken != null) {
  //     try {
  //       await UserService.instance.getUserInfor();
  //     } catch (error) {
  //       debugPrint(error.toString());
  //     }
  //   }
  // } catch (error) {
  //   debugPrint(error.toString());
  // }

  FlutterNativeSplash.remove();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ref.themeService.themeDate,
      locale: ref.locale,

      // 오버레이를 사용하기 위해 builder 사용
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => child!,
            )
          ],
        );
      },
    );
  }
}

// 루트 네비게이터 키

