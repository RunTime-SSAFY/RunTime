import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/route_path.dart';

final matchingViewModelProvider =
    ChangeNotifierProvider((ref) => MatchingViewModel());

enum MatchingState {
  beforeMatching,
  matching,
  matched,
  waitingOthers;
}

class MatchingViewModel with ChangeNotifier {
  void startTimer() {
    if (_hasTimer) return;
    int count = 0;
    _hasTimer = true;
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (count > 0) {
        count--;
      } else {
        _isMatched = true;
        notifyListeners();
        _timer.cancel();
        _hasTimer = false;
      }
    });
  }

  late Timer _timer;
  bool _hasTimer = false;

  int targetDistance = 3;

  void matchingStart(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.matching);
  }

  void onPressCancelDuringMatching(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onAcceptCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // matched의 수락 상태
  bool _isAccepted = false;
  bool get isAccepted => _isAccepted;
  void onAcceptMatching() {
    _timer.cancel();
    notifyListeners();
    _isAccepted = true;
  }

  void matched(BuildContext context) {
    _isAccepted = false;
    if (_isMatched) {
      Navigator.pushNamed(context, RoutePath.matched);
      _timer.cancel();
      _isMatched = false;
      _hasTimer = false;
    }
  }

  void onDenyMatching(BuildContext context) {
    Navigator.popAndPushNamed(context, RoutePath.beforeMatching);
    _timer.cancel();
    _isAccepted = false;
    _isMatched = false;
    _hasTimer = false;
  }

  bool _isMatched = false;

  void startBattle(BuildContext context) {
    _timer.cancel();
    _isAccepted = false;
    _isMatched = false;
    _hasTimer = false;

    Navigator.popAndPushNamed(
      context,
      RoutePath.battle,
      arguments: {
        RouteParameter.targetDistance: targetDistance,
      },
    );
  }
}
