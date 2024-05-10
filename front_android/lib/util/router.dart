import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/auth_service.dart';
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

// enum type에 값을 줄 수도 있어?

final authState = Provider((ref) => AuthService.instance);

final router = GoRouter(
  debugLogDiagnostics: true, // 디버깅 로그 출력
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login', // 초기 경로
  routes: [
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const LoginView(),
    ),
    GoRoute(
      path: '/matching',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const WaitingMatching(),
    ),
    GoRoute(
      path: '/beforeMatching',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const StartMatchingView(),
    ),
    GoRoute(
      path: '/matched',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const Matched(),
    ),
    GoRoute(
      path: '/battle',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const BattleResultView(),
    ),
    GoRoute(
      path: '/userMode',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const UserModeView(),
    ),
    GoRoute(
      path: '/waitingRoom :roomId',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const WaitingRoom(roomId: 0),
    ),
    GoRoute(
      path: '/userModeSearch',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const UserModeSearchView(),
    ),

    // 바텀내비게이션
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (_, __, child) => ScaffoldWithNavBar(child: child),
      routes: [
        GoRoute(
          path: '/main',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RunMainView()),
        ),
        GoRoute(
          path: '/achievement',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RunMainView()),
        ),
        GoRoute(
          path: '/characters',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RunMainView()),
        ),
        GoRoute(
          path: '/record',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RecordView()),
          routes: [
            GoRoute(
              path: 'detail',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const CupertinoPage(child: RecordDetailView()),
            ),
            GoRoute(
              path: 'statistics',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const CupertinoPage(child: StatisticsView()),
            ),
          ],
        ),
        GoRoute(
          path: '/profiles',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RunMainView()),
        ),
      ],
    )
  ],
  // refreshListenable: authState,
  // redirect: (context, state) {
  //   if (!authState.) {
  //     return '/signin';
  //   } else {
  //     return null;
  //   }
  // },
);
