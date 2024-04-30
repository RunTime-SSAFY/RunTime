import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class CountDown extends ConsumerStatefulWidget {
  const CountDown({
    super.key,
  });

  @override
  ConsumerState<CountDown> createState() => _CountDownState();
}

class _CountDownState extends ConsumerState<CountDown> {
  int _count = 3;
  Timer? _timer;

  void countDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_count > 0) {
        setState(() {
          _count--;
        });
      } else {
        _timer!.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

  @override
  Widget build(BuildContext contextm) {
    return Center(
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
            '$_count',
            style: ref.typo.mainTitle.copyWith(
              color: ref.color.onBackground,
              fontSize: 100,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
