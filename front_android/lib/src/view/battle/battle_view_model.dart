import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/repository/distance_repository.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';
import 'package:intl/intl.dart';

final battleViewProvider = ChangeNotifierProvider((ref) => BattleViewModel());

class BattleViewModel with ChangeNotifier {
  BattleViewModel() {
    _startTimer();
    distanceService = DistanceRepository();
  }
  late DistanceRepository distanceService;

  double get distanceNow => distanceService.distanceNow;

  final bool result = true;

  final int _point = 30;
  String get point => _point > 0 ? '+$_point' : '$_point';
  final String character = 'mainCharacter';
  double haveToRun = 1;

  int _avgPace = 0;
  int get avgPace => _avgPace;

  double _calory = 0;

  String get calory => _calory.toStringAsFixed(2);

  final DateTime _date = DateTime.now();

  String get date => DateFormat(DateFormat.YEAR_MONTH_DAY).format(_date);

  // GPS 초기 설정을 위해 로딩 시간 제외
  final DateTime _startTime = DateTime.now().add(const Duration(seconds: 4));

  DateTime get startTime => _startTime;

  DateTime _currentTime = DateTime.now();

  String get runningTime => _currentTime.difference(_startTime).toHhMmSs();

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      var seconds = _currentTime.difference(_startTime).inSeconds;
      _avgPace =
          (distanceNow * 100 / (((seconds == 0 ? 1 : seconds) / 60) * 100)) ~/
              100;

      _calory += (333 / 100000 * (70 * avgPace * 1036)) / 10000;
      notifyListeners();
    });
  }

  void onGiveUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onCancel: () {
            Navigator.popAndPushNamed(context, RoutePath.battleResult);
            _timer.cancel();
          },
          title: S.current.giveUp,
          content: S.current.ReallyGiveUpQuestion,
        );
      },
    );
  }

  void onResultDone(BuildContext context) {
    _timer.cancel();
    Navigator.popAndPushNamed(context, RoutePath.runMain);
  }

  void handlePopInBattle() {}
}
