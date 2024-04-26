import 'package:flutter/material.dart';
import 'package:front_android/src/view/battleMatching/battle_matching_view.dart';
import 'package:front_android/src/view/runMain/run_view.dart';

interface class RoutePath {
  static const String runMain = 'runMain';
  static const String battleMatching = 'battleMatching';
  static const String userMode = 'userMode';
  static const String practiceMode = 'practiceMode';
  static const String ranking = 'ranking';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case RoutePath.runMain:
        page = const RunMainView();
        break;
      case RoutePath.battleMatching:
        page = const BattleMatchingVIew();
        break;
      case RoutePath.userMode:
        break;
      case RoutePath.practiceMode:
        break;
      case RoutePath.ranking:
        break;
    }
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
