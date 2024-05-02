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
  void matchingStart(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.matching);
    notifyListeners();
  }

  void onPressCancelDuringMatching(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // matched의 수락 상태
  bool _isAccepted = false;
  bool get isAccepted => _isAccepted;
  void acceptBattle() {
    _isAccepted = true;

    notifyListeners();
  }

  void onDenyMatching(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.beforeMatching);
    notifyListeners();
  }

  void matchedOnPressButton() {
    notifyListeners();
  }

  void onAcceptMatching() {
    notifyListeners();
  }

  void startBattle(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.battle);
  }
}
