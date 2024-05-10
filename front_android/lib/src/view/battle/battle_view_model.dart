import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/distance_repository.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';
import 'package:intl/intl.dart';

final battleViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  return BattleViewModel(battleData);
});

class BattleViewModel with ChangeNotifier {
  final BattleDataService _battleData;

  List<Participant> get participants =>
      _battleData.getBattleDataSortByDistance();

  BattleViewModel(this._battleData) {
    var mode = _battleData.mode;

    // DistanceRepository 시작 - 거리 측정 및 서버에 보내기 시작
    distanceService = DistanceRepository(
        sendDestination:
            DestinationHelper.getBattleDestination(mode, _battleData.uuid),
        socket: _battleData.stompInstance);

    // 데이터 구독 시작
    _battleData.stompInstance.subScribe(
        destination: DestinationHelper.getForSub(mode, _battleData.uuid),
        callback: (p0) {
          var newParticipantsData =
              Participant.fromJson(jsonDecode(p0.body!)['data']);
          _battleData.changeParticipantsDistance(newParticipantsData);
        });
    _startTimer();
  }

  late final DistanceRepository distanceService;

  double get currentDistance => distanceService.currentDistance;

  final bool result = true;

  final int _point = 30;
  String get point => _point > 0 ? '+$_point' : '$_point';
  final String character = 'mainCharacter';
  double get targetDistance => _battleData.targetDistance;

  double _avgPace = 0;
  double get avgPace => _avgPace;

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
      _avgPace = _calculateTimePerKilometer(currentDistance, seconds);
      var velocity = distanceService.instantaneousVelocity;
      _calory +=
          157 * ((0.1 * velocity + (velocity == 0 ? 0 : 3.5)) / 3.5) / 1000;
      notifyListeners();
    });
  }

  double _calculateTimePerKilometer(
      double distanceInMeters, int elapsedTimeInSeconds) {
    if (elapsedTimeInSeconds == 0) {
      return 0;
    }

    double secondsPerMeter = distanceInMeters / elapsedTimeInSeconds;
    if (secondsPerMeter == 0) {
      return 0;
    }
    double timeForOneKilometerInSeconds = 1000 / secondsPerMeter;
    double timeForOneKilometerInMinutes =
        (timeForOneKilometerInSeconds / 6).round() / 10;

    return timeForOneKilometerInMinutes;
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
            _battleData.disconnect();
          },
          title: S.current.giveUp,
          content: S.current.ReallyGiveUpQuestion,
        );
      },
    );
  }

  void onBattleDone(BuildContext context) {
    _timer.cancel();
    distanceService.cancelListen();
    _battleData.disconnect();
    Navigator.popAndPushNamed(context, RoutePath.battleResult);
  }

  void onResultDone(BuildContext context) {
    Navigator.popAndPushNamed(context, RoutePath.runMain);
  }

  void getResult() async {}

  @override
  void dispose() {
    distanceService.cancelListen();
    _battleData.stompInstance.disconnect();
    super.dispose();
  }
}
