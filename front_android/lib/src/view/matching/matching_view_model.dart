import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

final matchingViewModelProvider =
    ChangeNotifierProvider.autoDispose<MatchingViewModel>((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  battleData.mode = BattleModeHelper.matching;
  return MatchingViewModel(battleData);
});

// 매칭된 후 수락, 거절, 응답 전의 상태
enum MatchedState {
  accept,
  deny,
  noResponse;
}

class MatchingViewModel with ChangeNotifier {
  final BattleDataService _battleData;

  MatchingViewModel(this._battleData);

  bool isMatched = false;

  // 매칭을 시작하기
  void onMatchingStart(BuildContext context) async {
    context.pushReplacement(RoutePathHelper.matching);
    _battleData.targetDistance = 100;

    // 매칭 시작하라는 요청
    try {
      await _battleData.matchingStart((bool startResponse) {
        if (startResponse) {
          _battleData.canStart = true;
        } else {
          _battleData.canStart = false;
          _matchedState = MatchedState.deny;
        }
        notifyListeners();
      }, () {
        isMatched = true;
        notifyListeners();
      });
    } catch (error) {
      // 에러 토스트 메세지
      debugPrint(error.toString());
      if (!context.mounted) return;
      context.pop();
    }
  }

  // 매칭 중 취소하기
  void onPressCancelDuringMatching(BuildContext context) async {
    try {
      await apiInstance.patch('api/matchings/cancel');
      _battleData.stompInstance.disconnect();
      if (!context.mounted) return;
      context.pop();
    } catch (error) {
      // 에러 토스트 메세지
    }
  }

  Timer? _timer;
  double get fullProgress => 5000;
  double _timerTime = 5000;
  double get currentProgress => _timerTime;

  // 매칭되고 나서 시작되는 제한시간 타이머
  // 타이머가 종료되면 응답에 따라 배틀 시작 또는 다시 매칭화면으로 이동
  void startTimer(BuildContext context) {
    _battleData.subReady(() {
      _matchedState = MatchedState.deny;
    });
    _timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (timer) {
        if (_timerTime > 0) {
          _timerTime -= 50;
        } else {
          _timer?.cancel();
          _timerTime = 5000;
          // 클라이언트가 수락 누른 경우
          if (_matchedState == MatchedState.accept) {
            startBattle(context);
          } else {
            // 클라이언트가 거절 누른 경우
            _battleData.canStart = false;
            context.pushReplacement(RoutePathHelper.beforeMatching);
            _matchedState = MatchedState.noResponse;
          }
        }
        notifyListeners();
      },
    );
  }

  // matched의 수락 상태
  MatchedState _matchedState = MatchedState.noResponse;
  bool get isResponded => _matchedState != MatchedState.noResponse;
  late final bool _canStart = _battleData.canStart;

  void onMatchingResponse(bool response) async {
    if (response) {
      _matchedState = MatchedState.accept;
    } else {
      _matchedState = MatchedState.deny;
      // 매칭 시작에 대한 소켓 구독 취소
      // _battleData.disconnect();
    }
    notifyListeners();

    // 매칭 수락 여부 전송, _matchedState == MatchedState.accept
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
    }
    notifyListeners();
  }

  void startBattle(BuildContext context) async {
    _matchedState = MatchedState.noResponse;
    if (_canStart) {
      // 상대도 수락한 경우
      context.pushReplacement(
        RoutePathHelper.battle,
      );
    } else {
      // 상대가 거절한 경우
      context.pushReplacement(RoutePathHelper.matching);
      try {
        await apiInstance.patch('api/matchings', data: {'difference': 200});
      } catch (error) {
        rethrow;
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
