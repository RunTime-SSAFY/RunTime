import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/extension.dart';

class BattleTime extends ConsumerStatefulWidget {
  const BattleTime({super.key});

  @override
  ConsumerState<BattleTime> createState() => _BattleTimeState();
}

class _BattleTimeState extends ConsumerState<BattleTime> {
  DateTime _currentTime = DateTime.now();

  // GPS 초기 설정을 위해 로딩 시간 제외
  final DateTime _startTime = DateTime.now().add(const Duration(seconds: 4));
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime.difference(_startTime).toHhMmSs(),
      style: ref.typo.mainTitle.copyWith(
        color: ref.color.onBackground,
        fontSize: 60,
      ),
    );
  }
}
