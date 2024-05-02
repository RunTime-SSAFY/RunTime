import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
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
  MatchingState _matchingState = MatchingState.beforeMatching;

  // 화면 이동 등 확실한 빌드 전에 실행! 빌드를 재실행 시키지 않음!
  set matchingState(MatchingState state) => _matchingState = state;

  bool _isAccepted = false;

  bool get isAccepted => _isAccepted;

  String get image {
    switch (_matchingState) {
      case MatchingState.beforeMatching:
        return 'beforeMatching';
      case MatchingState.matching:
        return 'matching';
      case MatchingState.matched:
        return 'matched';
      case MatchingState.waitingOthers:
        return 'waitingOthers';
    }
  }

  String get mainMessage {
    switch (_matchingState) {
      case MatchingState.beforeMatching:
        return S.current.beforeMatching;
      case MatchingState.matching:
        return S.current.matching;
      case MatchingState.matched:
        return S.current.matched;
      case MatchingState.waitingOthers:
        return S.current.waitingOthers;
    }
  }

  String get hintMassage {
    switch (_matchingState) {
      case MatchingState.beforeMatching:
        return S.current.beforeMatching;
      case MatchingState.matched:
        return S.current.matchedHint;
      default:
        return '';
    }
  }

  void matchingStart() {
    _matchingState = MatchingState.matching;
    notifyListeners();
  }

  void onPressCancelInBeforeMatching(BuildContext context) {
    Navigator.pop(context);
    _matchingState = MatchingState.beforeMatching;
    notifyListeners();
  }

  void acceptBattle(bool button) {
    if (button) {
      // Accept
      _isAccepted = true;
    } else {
      // Deny
    }
    notifyListeners();
  }

  void matchedOnPressButton() {
    _matchingState = MatchingState.matched;
    notifyListeners();
  }

  void onAcceptMatching() {
    _matchingState = MatchingState.waitingOthers;
    notifyListeners();
  }

  void onDenyMatching() {
    _matchingState = MatchingState.beforeMatching;
    notifyListeners();
  }

  void startBattle(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.battle);
  }
}
