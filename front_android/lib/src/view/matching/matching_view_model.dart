import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/route_path.dart';

final matchingViewModelProvider =
    ChangeNotifierProvider((ref) => MatchingViewModel());

// 매칭된 후 수락, 거절, 응답 전의 상태
enum MatchedState {
  accept,
  deny,
  noResponse;
}

class MatchingViewModel with ChangeNotifier {
  void startTempTimer() {
    if (_hasTempTimer) return;
    int count = 0;
    _hasTempTimer = true;
    _tempTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (count > 0) {
        count--;
      } else {
        _isMatched = true;
        notifyListeners();
        _tempTimer.cancel();
        _hasTempTimer = false;
      }
    });
  }

  late Timer _tempTimer;
  bool _hasTempTimer = false;

  int targetDistance = 3;

  void matchingStart(BuildContext context) {
    Navigator.popAndPushNamed(context, RoutePath.matching);
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

  Timer? _timer;
  int get fullProgress => 5000;
  int _timerTime = 5000;
  int get currentProgress => _timerTime;

  void startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_timerTime > 0) {
        _timerTime -= 50;
        notifyListeners();
      } else {
        _tempTimer.cancel();
        _isMatched = false;
        _hasTempTimer = false;
        _timer?.cancel();
        _timerTime = 5000;
        if (_matchedState == MatchedState.accept) {
          _matchedState = MatchedState.noResponse;
          startBattle(context);
        } else {
          _matchedState = MatchedState.noResponse;
          Navigator.popAndPushNamed(context, RoutePath.beforeMatching);
        }
      }
    });
  }

  // 매칭이 시작된 상태 아직 매칭이 완료되지는 않음
  void matching(BuildContext context) {
    _matchedState = MatchedState.noResponse;
    if (_isMatched) {
      Navigator.popAndPushNamed(context, RoutePath.matched);
      _tempTimer.cancel();
      _isMatched = false;
      _hasTempTimer = false;
    }
  }

  // matched의 수락 상태
  MatchedState _matchedState = MatchedState.noResponse;
  bool get isResponded => _matchedState != MatchedState.noResponse;

  void onMatchingResponse(bool response) {
    _tempTimer.cancel();
    if (response) {
      _matchedState = MatchedState.accept;
    } else {
      _matchedState = MatchedState.deny;
    }
    notifyListeners();
  }

  bool _isMatched = false;

  void startBattle(BuildContext context) {
    Navigator.popAndPushNamed(
      context,
      RoutePath.battle,
      arguments: {
        RouteParameter.targetDistance: targetDistance,
      },
    );
  }
}
