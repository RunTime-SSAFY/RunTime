import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/https_request.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  api.interceptors.add(interceptors);

  // Kakao SDK
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"),
    javaScriptAppKey: dotenv.get("KAKAO_JAVASCRIPT_KEY"),
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
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
      initialRoute: RoutePath.login,
      onGenerateRoute: RoutePath.onGenerateRoute,
      locale: ref.locale,
    );
  }
}
