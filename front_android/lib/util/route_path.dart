import 'package:flutter/material.dart';
import 'package:front_android/src/view/battle/battle_result_view.dart';
import 'package:front_android/src/view/battle/battle_view.dart';
import 'package:front_android/src/view/login/login_view.dart';
import 'package:front_android/src/view/matching/before_matching_view.dart';
import 'package:front_android/src/view/matching/matched.dart';
import 'package:front_android/src/view/matching/waiting_matching_view.dart';
import 'package:front_android/src/view/record/record_view.dart';
import 'package:front_android/src/view/run_main/run_main_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_search_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_view.dart';
import 'package:front_android/src/view/waiting_room/waiting_room_view.dart';

enum RouteParameter {
  targetDistance;
}

interface class RoutePath {
  static const String runMain = 'runMain';
  static const String beforeMatching = 'beforeMatching';
  static const String matching = 'matching';
  static const String matched = 'matched';
  static const String userMode = 'userMode';
  static const String waitingRoom = 'waitingRoom';
  static const String userModeSearch = 'userModeSearch';
  static const String practiceMode = 'practiceMode';
  static const String ranking = 'ranking';
  static const String login = 'login';
  static const String battle = 'battle';
  static const String battleResult = 'battleResult';

  // 기록
  static const String record = 'record';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;

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
      case RoutePath.battleResult:
        page = const BattleResultView();
        break;
      case RoutePath.userMode:
        page = const UserModeView();
        break;
      case RoutePath.waitingRoom:
        assert(
          settings.arguments != null,
          'WaitingRoomView는 WaitingRoomArguments가 필요합니다.',
        );
        final args = settings.arguments as WaitingRoomArguments;
        page = WaitingRoom(roomId: args.roomId);
        break;
      case RoutePath.userModeSearch:
        page = const UserModeSearchView();
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
