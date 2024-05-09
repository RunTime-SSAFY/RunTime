import 'package:flutter/material.dart';
import 'package:front_android/src/view/battle/battle_result_view.dart';
import 'package:front_android/src/view/battle/battle_view.dart';
import 'package:front_android/src/view/login/login_view.dart';
import 'package:front_android/src/view/matching/before_matching_view.dart';
import 'package:front_android/src/view/matching/matched.dart';
import 'package:front_android/src/view/matching/waiting_matching_view.dart';
import 'package:front_android/src/view/profile/profile_edit_view.dart';
import 'package:front_android/src/view/record/record_detail_view.dart';
import 'package:front_android/src/view/record/record_view.dart';
import 'package:front_android/src/view/record/statistics_view.dart';
import 'package:front_android/src/view/record/widgets/map_test.dart';
import 'package:front_android/src/view/run_main/run_main_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_search_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_view.dart';
import 'package:front_android/src/view/waiting_room/waiting_room_view.dart';

enum RouteParameter {
  targetDistance;
}

interface class RoutePath {
  // 로그인 & 메인
  static const String login = 'login';
  static const String runMain = 'runMain';

  // 배틀
  static const String battle = 'battle';
  static const String battleResult = 'battleResult';

  // 매칭
  static const String beforeMatching = 'beforeMatching';
  static const String matching = 'matching';
  static const String matched = 'matched';

  // 유저 모드
  static const String userMode = 'userMode';
  static const String waitingRoom = 'waitingRoom';
  static const String userModeSearch = 'userModeSearch';

  // 연습 모드
  static const String practiceMode = 'practiceMode';

  // 랭킹
  static const String ranking = 'ranking';

  // 기록
  static const String record = 'record';

  // 프로필
  static const String profile = 'profile';
  static const String recordDetail = 'recordDetail';
  static const String statistics = 'statistics';

  // Test
  static const String mapTest = 'mapTest';

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
      case RoutePath.profile:
        page = const ProfileEditView();
        break;
      case RoutePath.mapTest:
        page = const MapTest();
        break;
      case RoutePath.recordDetail:
        page = const RecordDetailView();
        // assert(
        //   settings.arguments != null,
        //   'RecordDetailView는 Record가 필요합니다.',
        // );
        // final args = settings.arguments as RecordDetailArguments;
        // page = RecordDetailView(record: args.record);
        break;
      case RoutePath.statistics:
        page = const StatisticsView();
        break;
    }
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
