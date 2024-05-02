import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';

final matchingViewModelProvider = Provider((ref) => MatchingViewModel());

enum MatchingState {
  beforeMatching,
  matching,
  matched,
  waitingOthers;
}

class MatchingViewModel {
  MatchingState _matchingState = MatchingState.beforeMatching;

  MatchingState get matchingState => _matchingState;

  set matchingState(MatchingState state) => _matchingState = state;

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
  }

  void toBeforeMatching() {
    _matchingState = MatchingState.beforeMatching;
  }

  void matched() {
    _matchingState = MatchingState.matched;
  }

  void onAcceptMatching() {
    _matchingState = MatchingState.waitingOthers;
  }

  void onDenyMatching() {
    _matchingState = MatchingState.beforeMatching;
  }

  void startBattle(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.battle);
  }
}
