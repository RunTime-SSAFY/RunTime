import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final clock = NotifierProvider<Clock, String>(() {
  return Clock();
});

class Clock extends Notifier<String> {
  @override
  String build() => '';

  void initState() {
    // 1초 마다 현재 시간을 업데이트
    Timer.periodic(const Duration(seconds: 1), (timer) {
      state = DateFormat('yyyy-MM-dd (E)\nHH:mm:ss').format(DateTime.now());
    });
  }
}
