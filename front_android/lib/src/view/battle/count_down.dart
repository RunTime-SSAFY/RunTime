import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/widgets/battleLayout.dart';
import 'package:front_android/util/route_path.dart';

class CountDownView extends ConsumerStatefulWidget {
  const CountDownView({super.key});

  @override
  ConsumerState<CountDownView> createState() => _CountDownViewState();
}

class _CountDownViewState extends ConsumerState<CountDownView> {
  late Timer _timer;
  late int _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = 3;
    countDown();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void countDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentTime > 0) {
        setState(() {
          _currentTime--;
        });
      } else {
        _timer.cancel();
        Navigator.pushNamed(context, RoutePath.battle);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BattleLayout(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Ready',
              style: ref.typo.headline1.copyWith(
                color: ref.color.onBackground,
              ),
            ),
            Text(
              '$_currentTime',
              style: ref.typo.mainTitle.copyWith(
                color: ref.color.onBackground,
                fontSize: 100,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
