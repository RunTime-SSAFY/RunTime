import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';
import 'package:intl/intl.dart';

final battleViewProvider = ChangeNotifierProvider((ref) => BattleViewModel());

class BattleViewModel with ChangeNotifier {
  BattleViewModel() {
    _startTimer();
  }
  final bool result = true;

  final int _point = 30;
  String get point => _point > 0 ? '+$_point' : '$_point';
  final String character = 'mainCharacter';
  final double _distance = 1;
  String get distance => _distance.toStringAsFixed(0);
  final int _avgPace = 630;
  String get avgPace => _avgPace.toString();
  final int _calory = 155;
  String get calory => '${_calory.toString()}Kcal';

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
      print('타이머$_currentTime');
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
    Navigator.popAndPushNamed(context, RoutePath.runMain);
  }

  void handlePopInBattle() {}

  void onPop(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onCancel: () {},
        );
      },
    );
  }
}
