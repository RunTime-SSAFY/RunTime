import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/repository/distance_repository.dart';
import 'package:front_android/src/repository/socket_repository.dart';
import 'package:front_android/src/service/socket_service.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';
import 'package:intl/intl.dart';

final battleViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var socket = ref.watch(socketProvider);
  return BattleViewModel(socket);
});

class BattleViewModel with ChangeNotifier {
  final SocketRepository _socket;

  BattleViewModel(this._socket) {
    _startTimer();
    battleSocketStreamHandler = BattleSocket();
    distanceService = DistanceRepository(battleSocketStreamHandler);
  }
  late final DistanceRepository distanceService;
  late final BattleSocket battleSocketStreamHandler;

  double get currentDistance => distanceService.currentDistance;

  final bool result = true;

  final int _point = 30;
  String get point => _point > 0 ? '+$_point' : '$_point';
  final String character = 'mainCharacter';
  double targetDistance = 1000;

  int _avgPace = 0;
  int get avgPace => _avgPace;

  double _calory = 0;

  String get calory => _calory.toStringAsFixed(2);

  final DateTime _date = DateTime.now();

  String get date => DateFormat(DateFormat.YEAR_MONTH_DAY).format(_date);

  // GPS 초기 설정을 위해 로딩 시간 제외
  final DateTime _startTime = DateTime.now().add(const Duration(seconds: 4));
  DateTime _currentTime = DateTime.now();
  String get runningTime => _currentTime.difference(_startTime).toHhMmSs();

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      var seconds = _currentTime.difference(_startTime).inSeconds;
      _avgPace =
          (currentDistance * 10000 / (((seconds == 0 ? 1 : seconds) / 60))) ~/
              1000000;
      var velocity = distanceService.instantaneousVelocity;
      _calory +=
          157 * ((0.1 * velocity + (velocity == 0 ? 0 : 3.5)) / 3.5) / 1000;
      notifyListeners();
    });
  }

  void onGiveUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onAcceptCancel: () {
            Navigator.popAndPushNamed(context, RoutePath.battleResult);
            _timer.cancel();
            distanceService.cancelListen();
          },
          title: S.current.giveUp,
          content: S.current.ReallyGiveUpQuestion,
        );
      },
    );
  }

  void onResultDone(BuildContext context) {
    Navigator.popAndPushNamed(context, RoutePath.runMain);
  }

  void handlePopInBattle() {}

  @override
  void dispose() {
    distanceService.cancelListen();
    battleSocketStreamHandler.close();
    super.dispose();
  }
}
