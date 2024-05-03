import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/src/view/battle/widgets/count_down.dart';
import 'package:front_android/util/helper/extension.dart';

class Distance extends ConsumerStatefulWidget {
  const Distance({
    super.key,
  });

  @override
  ConsumerState<Distance> createState() => _DistanceTimeState();
}

class _DistanceTimeState extends ConsumerState<Distance> {
  OverlayEntry? _countDownOverlay;
  // 초기 GPS 접근 시간 확보
  void _showOverlay() {
    _countDownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ref.color.battleBackground1,
                  ref.color.battleBackground2,
                ],
              ),
            ),
            child: const CountDown(),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_countDownOverlay!);

    Future.delayed(const Duration(seconds: 4), () {
      _countDownOverlay?.remove();
      _countDownOverlay = null;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
  }

  @override
  Widget build(BuildContext context) {
    BattleViewModel viewModel = ref.watch(battleViewProvider);
    BattleViewModel battleViewModel = ref.watch(battleViewProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          viewModel.distanceNow.toKilometer(),
          style: ref.typo.headline1.copyWith(
            color: ref.color.onBackground,
            fontSize: 60,
          ),
        ),
        Text(
          ' / ${battleViewModel.haveToRun}km',
          style: ref.typo.body1.copyWith(
            color: ref.color.onBackground,
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}
