import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/service/socket_service.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/helper/socket_helper.dart';
import 'package:front_android/util/route_path.dart';

final matchingViewModelProvider =
    ChangeNotifierProvider.autoDispose<MatchingViewModel>((ref) {
  var socket = ref.watch(socketProvider);
  return MatchingViewModel(socket);
});

// 매칭된 후 수락, 거절, 응답 전의 상태
enum MatchedState {
  accept,
  deny,
  noResponse;
}

class MatchingViewModel with ChangeNotifier {
  final SocketService _socket;

  MatchingViewModel(this._socket);

  int targetDistance = 3;

  // 매칭을 시작하기
  void toMatchingStartView(BuildContext context) {
    // 화면 이동
    Navigator.popAndPushNamed(context, RoutePath.matching);

    // 매칭 시작하라는 요청
    _socket.emit(SocketHelper.matchingStart);

    // 매칭이 시작된 상태 아직 매칭이 되지는 않음

    // 매칭이 됨
    _socket.on(SocketHelper.matching, (data) {
      // 방의 id와 상대의 id
      print(data);
      // 소켓 인스턴스에 방의 정보를 저장한 뒤 매칭 수락, 거절 화면으로 이동
      _socket.roomData = MatchingRoomData.fromJson(data);
      Navigator.popAndPushNamed(context, RoutePath.matched);
    });
  }

  // 매칭 중 취소하기
  void onPressCancelDuringMatching(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onAcceptCancel: () {
            // 취소하면 소켓 연결 해제
            _socket.close();
            Navigator.pop(context);
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
          _isOpponentAccept = false;
          Navigator.popAndPushNamed(context, RoutePath.beforeMatching);
        }
      }
    });
  }

  // matched의 수락 상태
  MatchedState _matchedState = MatchedState.noResponse;
  bool get isResponded => _matchedState != MatchedState.noResponse;
  bool _isOpponentAccept = false;

  void onMatchingResponse(bool response) {
    if (response) {
      _matchedState = MatchedState.accept;
    } else {
      _matchedState = MatchedState.deny;
      // 매칭 시작에 대한 소켓 구독 취소
      _socket.off(SocketHelper.matchingStart);
    }

    // 매칭이 되면 수락 여부, _matchedState == MatchedState.accept
    //방 Id,
    //그리고 나의 id(token)를 같이 보낸다.
    _socket.emit(SocketHelper.matching);
    notifyListeners();
  }

  void startBattle(BuildContext context) {
    if (_isOpponentAccept) {
      // 상대도 수락한 경우
      // 남아있는 매칭 요청에 대한 구독 취소
      _socket.off(SocketHelper.matchingStart);
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
