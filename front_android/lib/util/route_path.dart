import 'package:flutter/material.dart';
import 'package:front_android/src/view/runMain/run_view.dart';

interface class RoutePath {
  static const String runMain = 'runMain';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case RoutePath.runMain:
        page = const RunMainView();
        break;
    }
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
