import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/util/router.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_android/src/repository/secure_storage_repository.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:front_android/util/route_path.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  // Kakao SDK
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"),
    javaScriptAppKey: dotenv.get("KAKAO_JAVASCRIPT_KEY"),
  );

  String initialRoute = RoutePath.runMain;

  apiInstance.interceptors.add(CustomInterceptor(
    authService: AuthService.instance,
  ));

  try {
    final refreshToken = await SecureStorageRepository.instance.refreshToken;
    if (refreshToken == null) {
      initialRoute = RoutePath.login;
    } else {
      try {
        var response = await apiInstance.get('api/members');
        var data = response.data;
        var userService = UserService.instance;
        userService.nickname = data['nickname'] ?? '';
        userService.characterImgUrl = data['characterImgUrl'] ?? '';
        userService.weight = data['weight'] ?? '';
        await UserService.instance.getUserInfor();
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  } catch (error) {
    debugPrint(error.toString());
  }

  var key = await KakaoSdk.origin;
  print(key);

  runApp(ProviderScope(child: MyApp(initialRoute: initialRoute)));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService authService = ref.watch(authProvider);
    apiInstance.interceptors.add(CustomInterceptor(
      context: context,
      authService: authService,
    ));

    return MaterialApp.router(
      routerConfig: router,
    return MaterialApp(
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
      // 전역에서 모든 context를 Overlay로 관리해도 괜찮은걸까요? 계속해서 새로운 context가 생길 때마다 새로운 Overlay가 기존의 context 위에 쌓일 것 같습니다.
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
    // return MaterialApp(
    //   localizationsDelegates: const [
    //     S.delegate,
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //     GlobalCupertinoLocalizations.delegate,
    //   ],
    //   supportedLocales: S.delegate.supportedLocales,
    //   navigatorKey: navigatorKey,
    //   builder: (context, child) {
    //     return Overlay(
    //       initialEntries: [
    //         OverlayEntry(
    //           builder: (context) => child!,
    //         )
    //       ],
    //     );
    //   },
    //   theme: ref.themeService.themeDate,
    //   // initialRoute: RoutePath.runMain,
    //   initialRoute: RoutePath.record,
    //   onGenerateRoute: RoutePath.onGenerateRoute,
    //   locale: ref.locale,
    // );
      theme: ref.themeService.themeDate,
      initialRoute: initialRoute,
      onGenerateRoute: RoutePath.onGenerateRoute,
      locale: ref.locale,
    );
  }
}

// 루트 네비게이터 키

