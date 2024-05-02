import 'package:flutter/material.dart';
import 'package:front_android/src/service/secure_storage_service.dart';
import 'package:front_android/src/view/battle/battle_view.dart';
import 'package:front_android/src/view/login/login_view.dart';
import 'package:front_android/src/view/matching/before_matching_view.dart';
import 'package:front_android/src/view/matching/matched.dart';
import 'package:front_android/src/view/matching/wating_matching_view.dart';
import 'package:front_android/src/view/runMain/run_view.dart';
import 'package:front_android/src/view/record/record_view.dart';

interface class RoutePath {
  static const String runMain = 'runMain';
  static const String beforeMatching = 'beforeMatching';
  static const String matching = 'matching';
  static const String matched = 'matched';
  static const String userMode = 'userMode';
  static const String practiceMode = 'practiceMode';
  static const String ranking = 'ranking';
  static const String login = 'login';
  static const String battle = 'battle';

  // 기록
  static const String record = 'record';

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
        page = const WaitingMatching();
        break;
      case RoutePath.beforeMatching:
        page = const StartMatchingView();
        break;
      case RoutePath.matched:
        page = const Matched();
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
      case RoutePath.record:
        page = const RecordView();
        break;
    }
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
