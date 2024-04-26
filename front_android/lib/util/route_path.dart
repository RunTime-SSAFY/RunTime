import 'package:flutter/material.dart';
import 'package:front_android/src/view/battleMatching/battle_matching_view.dart';
import 'package:front_android/src/view/runMain/run_view.dart';

interface class RoutePath {
  static const String runMain = 'runMain';
  static const String BattleMatching = 'battleMatching';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case RoutePath.runMain:
        page = const RunMainView();
        break;
      case RoutePath.BattleMatching:
        page = const BattleMatchingVIew();
    }
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
