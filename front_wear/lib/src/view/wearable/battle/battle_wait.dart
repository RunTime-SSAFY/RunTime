import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_wear/src/service/theme_service.dart';
import 'package:front_wear/src/view/wearable/battle/battle_main.dart';
import 'package:timer_count_down/timer_count_down.dart';

class BattleWait extends ConsumerStatefulWidget {
  const BattleWait({
    super.key,
    required this.comments,
    //required this.timeSet,
  });

  final String comments;
  //final void Function() timeSet;

  @override
  _BattleWaitState createState() => _BattleWaitState();
}

class _BattleWaitState extends ConsumerState<BattleWait> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  String _elapsedTime = '0:00';

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _startStopwatch();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {
          _elapsedTime = _formatElapsedTime(_stopwatch.elapsedMilliseconds);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  String _formatElapsedTime(int milliseconds) {
    final int hundreds = (milliseconds / 10).truncate();
    final int seconds = (hundreds / 100).truncate();
    final int minutes = (seconds / 60).truncate();

    final String minutesStr = (minutes % 60).toString().padLeft(1, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  void _startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
  }

  void _stopStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BattleMain()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.comments,
                  //'상대를 찾는 중',
                  style: ref.typo.wSubTitle.copyWith(
                    color: ref.color.wBattleMode,
                  ),
                ),
                Text(
                  _elapsedTime,
                  style: ref.typo.wCounter,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: _stopStopwatch,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(), backgroundColor: ref.color.wDeny,
                padding: const EdgeInsets.all(20), // 버튼 배경색
                elevation: 0,
              ),
              child: SvgPicture.asset(
                'assets/icons/Cancel.svg',
                width: 13,
                height: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BattleFoundState extends ConsumerState<BattleWait> {
  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: 10,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: const Duration(milliseconds: 100),
      onFinished: () {
        const Text(
          '게임 시작',
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const GamePage(children: [
        //       Text(""),
        //       ref.color.wBattleMode,
        //       ref.color.black,
        //     ]),
        //   ),
        // );
      },
    );
  }
}
