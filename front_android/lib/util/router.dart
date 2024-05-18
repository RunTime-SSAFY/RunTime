import 'package:flutter/cupertino.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/model/record_detail.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:front_android/src/view/achievement/achievement_reward_view.dart';
import 'package:front_android/src/view/achievement/achievement_view.dart';
import 'package:front_android/src/view/battle/battle_result_view.dart';
import 'package:front_android/src/view/battle/battle_view.dart';
import 'package:front_android/src/view/login/login_view.dart';
import 'package:front_android/src/view/matching/before_matching_view.dart';
import 'package:front_android/src/view/matching/matched.dart';
import 'package:front_android/src/view/matching/waiting_matching_view.dart';
import 'package:front_android/src/view/practice/practice_view.dart';
import 'package:front_android/src/view/profile/profile_edit_view.dart';
import 'package:front_android/src/view/profile/profile_view.dart';
import 'package:front_android/src/view/record/record_view.dart';
import 'package:front_android/src/view/record_detail/record_detail_view.dart';
import 'package:front_android/src/view/run_main/run_main_view.dart';
import 'package:front_android/src/view/statistic/statistic_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_search_view.dart';
import 'package:front_android/src/view/user_mode/user_mode_view.dart';
import 'package:front_android/src/view/waiting_room/waiting_room_view.dart';
import 'package:front_android/theme/components/scaffold_with_nav_bar.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// enum type에 값을 줄 수도 있어?

final router = GoRouter(
  debugLogDiagnostics: true, // 디버깅 로그 출력
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePathHelper.runMain, // 초기 경로
  routes: [
    GoRoute(
      path: '/',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const RunMainView(),
    ),
    GoRoute(
      path: RoutePathHelper.login,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const LoginView(),
    ),
    GoRoute(
      path: RoutePathHelper.matching,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const WaitingMatching(),
    ),
    GoRoute(
      path: RoutePathHelper.beforeMatching,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const StartMatchingView(),
    ),
    GoRoute(
      path: RoutePathHelper.matched,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const Matched(),
    ),
    GoRoute(
      path: RoutePathHelper.battle,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const Battle(),
    ),
    GoRoute(
      path: RoutePathHelper.battleResult,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const BattleResultView(),
    ),
    GoRoute(
      path: RoutePathHelper.userMode,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const UserModeView(),
    ),
    GoRoute(
        path: RoutePathHelper.waitingRoom,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (_, state) {
          final roomId = state.pathParameters['roomId']!;
          final data = state.extra as Map<String, dynamic>;
          return WaitingRoom(
            roomId: int.parse(roomId),
            data: data,
          );
        }),
    GoRoute(
      path: RoutePathHelper.userModeSearch,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const UserModeSearchView(),
    ),

    GoRoute(
      path: RoutePathHelper.practiceMode,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, __) => const Practice(),
    ),

    // 도전과제 보상 화면

    // 바텀내비게이션
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (_, __, child) => ScaffoldWithNavBar(child: child),
      routes: [
        GoRoute(
          path: RoutePathHelper.runMain,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RunMainView()),
        ),
        GoRoute(
          path: RoutePathHelper.achievement,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: AchievementView()),
          routes: [
            GoRoute(
              path: 'reward',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return CupertinoPage(
                  child: AchievementRewardView(
                    data: state.extra as AchievementRewardRequest,
                  ),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: RoutePathHelper.character,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RunMainView()),
        ),
        GoRoute(
          path: RoutePathHelper.record,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: RecordView()),
          routes: [
            GoRoute(
              path: 'detail',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  CupertinoPage(
                      child: RecordDetailView(
                          recordDetail: state.extra as RecordDetail)),
            ),
            GoRoute(
              path: 'statistic',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  const CupertinoPage(child: StatisticView()),
            ),
          ],
        ),
        GoRoute(
          path: RoutePathHelper.profile,
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: ProfileView()),
          routes: [
            GoRoute(
              path: 'edit',
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileEditView()),
            )
          ],
        ),
      ],
    )
  ],
  redirect: (context, state) {
    if (AuthService.instance.refreshToken == null) {
      return RoutePathHelper.login;
    } else {
      return null;
    }
  },
);
