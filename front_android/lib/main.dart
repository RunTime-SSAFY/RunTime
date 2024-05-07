import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
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

  FlutterSecureStorage? secureStorage = const FlutterSecureStorage();

  String initialRoute = RoutePath.runMain;

  try {
    final accessToken = await secureStorage.read(key: 'accessToken');
    if (accessToken == null) {
      initialRoute = RoutePath.login;
    }
    // final newAccessToken = loginWithRefreshToken(refreshToken);
    //   if (newAccessToken != null) {
    // await secureStorage.write(key: 'accessToken', value: newAccessToken);
    // }
  } catch (error) {
    debugPrint(error.toString());
  }

  secureStorage = null;

  runApp(ProviderScope(child: MyApp(initialRoute: initialRoute)));
}

class MyApp extends ConsumerWidget {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => child!,
            )
          ],
        );
      },
      theme: ref.themeService.themeDate,
      initialRoute: initialRoute,
      onGenerateRoute: RoutePath.onGenerateRoute,
      locale: ref.locale,
    );
  }
}
