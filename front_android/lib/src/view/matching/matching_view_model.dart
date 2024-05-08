import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/route_path.dart';

final matchingViewModelProvider =
    ChangeNotifierProvider.autoDispose<MatchingViewModel>((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  return MatchingViewModel(battleData);
});

// 매칭된 후 수락, 거절, 응답 전의 상태
enum MatchedState {
  accept,
  deny,
  noResponse;
}

class MatchingViewModel with ChangeNotifier {
  final SocketService _battleData;

  MatchingViewModel(this._battleData);

  int targetDistance = 3;

  // 매칭을 시작하기
  void toMatchingStartView(BuildContext context) async {
    // 화면 이동
    Navigator.popAndPushNamed(context, RoutePath.matching);

    // 매칭 시작하라는 요청
    try {
      await _battleData.matchingStart(
        (bool startResponse) {
          _canStart = startResponse;
        },
      );
    } catch (error) {
      // 에러 토스트 메세지
      print(error.toString());
      Navigator.pop(context);
    }
  }

  // 매칭 중 취소하기
  void onPressCancelDuringMatching(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onAcceptCancel: () async {
            // 취소하면 소켓 연결 해제
            try {
              await apiInstance.patch('api/matchings/cancel');
              _battleData.stompInstance.disconnect();
              Navigator.pop(context);
            } catch (error) {
              // 에러 토스트 메세지
            }
          },
        );
      },
    );
  }

  Timer? _timer;
  double get fullProgress => 5000;
  double _timerTime = 5000;
  double get currentProgress => _timerTime;

  // 매칭되고 나서 시작되는 제한시간 타이머
  // 타이머가 종료되면 응답에 따라 배틀 시작 또는 다시 매칭화면으로 이동
  void startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_timerTime > 0) {
        _timerTime -= 50;
        notifyListeners();
      } else {
        _timer?.cancel();
        _timerTime = 5000;
        // 클라이언트가 수락 누른 경우
        if (_matchedState == MatchedState.accept) {
          _matchedState = MatchedState.noResponse;
          startBattle(context);
        } else {
          // 클라이언트가 거절 누른 경우
          _matchedState = MatchedState.noResponse;
          _canStart = false;
          Navigator.popAndPushNamed(context, RoutePath.beforeMatching);
        }
      }
    });
  }

  // matched의 수락 상태
  MatchedState _matchedState = MatchedState.noResponse;
  bool get isResponded => _matchedState != MatchedState.noResponse;
  bool _canStart = false;

  void onMatchingResponse(bool response) async {
    if (response) {
      _matchedState = MatchedState.accept;
    } else {
      _matchedState = MatchedState.deny;
      // 매칭 시작에 대한 소켓 구독 취소
      _battleData.disconnect();
    }

    // 매칭이 되면 수락 여부 전송, _matchedState == MatchedState.accept
    try {
      await apiInstance.patch(
        'api/matchings/${_battleData.roomId}/ready',
        data: {
          'ready': _matchedState == MatchedState.accept,
        },
      );
    } catch (error) {
      // 오류 토스트 메세지
      _matchedState = MatchedState.noResponse;
      print(error);
    }
    notifyListeners();
  }

  void startBattle(BuildContext context) {
    if (_canStart) {
      // 상대도 수락한 경우
      Navigator.popAndPushNamed(
        context,
        RoutePath.battle,
        arguments: {
          RouteParameter.targetDistance: targetDistance,
        },
      );
    } else {
      /// 상대가 거절한 경우
      _matchedState = MatchedState.noResponse;
      Navigator.popAndPushNamed(context, RoutePath.matching);
    }
  }
}
