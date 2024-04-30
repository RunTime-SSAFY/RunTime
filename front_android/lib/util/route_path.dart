import 'package:flutter/material.dart';
import 'package:front_android/src/service/secure_storage_service.dart';
import 'package:front_android/src/view/battle/battle/battle.dart';
import 'package:front_android/src/view/battle/count_down.dart';
import 'package:front_android/src/view/battle/foundMatching/found_matching_view.dart';
import 'package:front_android/src/view/battle/matching_view.dart';
import 'package:front_android/src/view/battle/start_matching_view.dart';
import 'package:front_android/src/view/login/login_view.dart';
import 'package:front_android/src/view/runMain/run_view.dart';

interface class RoutePath {
  static const String runMain = 'runMain';
  static const String matchingStart = 'startMatching';
  static const String matching = 'matching';
  static const String foundMatching = 'foundMatching';
  static const String userMode = 'userMode';
  static const String practiceMode = 'practiceMode';
  static const String ranking = 'ranking';
  static const String login = 'login';
  static const String countDown = 'countDown';
  static const String battle = 'battle';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;

    // 페이지를 이동할 때 로그인이 안되어 있으면 로그인 페이지로 이동
    void isLogin() async {
      final refreshToken = await SecureStorageService.refreshToken;
      final refreshTokenExpireDate =
          await SecureStorageService.refreshTokenExpireDate;

      if (refreshToken == null ||
          DateTime.now().isAfter(refreshTokenExpireDate)) {
        page = const LoginView();
        return;
      }
    }

    // isLogin();

    switch (settings.name) {
      case RoutePath.runMain:
        page = const RunMainView();
        break;
      case RoutePath.matching:
        page = const Matching();
        break;
      case RoutePath.matchingStart:
        page = const StartMatchingView();
        break;
      case RoutePath.foundMatching:
        page = const FoundMatching();
        break;
      case RoutePath.countDown:
        page = const CountDownView();
        break;
      case RoutePath.battle:
        page = const Battle();
        break;
      case RoutePath.userMode:
        break;
      case RoutePath.practiceMode:
        break;
      case RoutePath.ranking:
        break;
      case RoutePath.login:
        page = const LoginView();
        break;
    }
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
