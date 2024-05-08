import 'package:flutter/material.dart';
import 'package:front_android/src/view/battle/battle_result_view.dart';
import 'package:front_android/src/view/login/login_view.dart';
import 'package:front_android/src/view/matching/before_matching_view.dart';
import 'package:front_android/src/view/matching/matched.dart';
import 'package:front_android/src/view/matching/waiting_matching_view.dart';
import 'package:front_android/src/view/record/record_detail_view.dart';
import 'package:front_android/src/view/record/record_view.dart';
import 'package:front_android/src/view/record/statistics_view.dart';
import 'package:front_android/src/view/run_main/run_main_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_search_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_view.dart';
import 'package:front_android/src/view/waiting_room/waiting_room_view.dart';
import 'package:front_android/theme/components/scaffold_with_nav_bar.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/main',
  routes: [
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginView(),
    ),

    GoRoute(
      path: '/matching',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const WaitingMatching(),
    ),
    GoRoute(
      path: '/beforeMatching',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const StartMatchingView(),
    ),
    GoRoute(
      path: '/matched',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const Matched(),
    ),
    GoRoute(
      path: '/battle',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const BattleResultView(),
    ),
    GoRoute(
      path: '/userMode',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const UserModeView(),
    ),
    GoRoute(
      path: '/waitingRoom :roomId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const WaitingRoom(roomId: 0),
    ),
    GoRoute(
      path: '/userModeSearch',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const UserModeSearchView(),
    ),
    GoRoute(
      path: '/recordDetail :recordId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RecordDetailView(),
    ),
    GoRoute(
      path: '/statistics',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const StatisticsView(),
    ),

    // 바텀내비게이션
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ScaffoldWithNavBar(child: child),
      routes: [
        GoRoute(
          path: '/main',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const RunMainView(),
        ),
        GoRoute(
          path: '/achievement',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const RunMainView(),
        ),
        GoRoute(
          path: '/characters',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const RunMainView(),
        ),
        GoRoute(
          path: '/record',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const RecordView(),
          routes: [
            GoRoute(
              path: 'statistics',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const StatisticsView(),
            ),
          ],
        ),
        GoRoute(
          path: '/profiles',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const RunMainView(),
        ),
      ],
    )
  ],
);
