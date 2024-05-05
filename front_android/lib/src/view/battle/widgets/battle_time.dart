import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';

class BattleTime extends ConsumerStatefulWidget {
  const BattleTime({super.key});

  @override
  ConsumerState<BattleTime> createState() => _BattleTimeState();
}

class _BattleTimeState extends ConsumerState<BattleTime> {
  @override
  Widget build(BuildContext context) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);

    return Text(
      viewModel.runningTime,
      style: ref.typo.subTitle1.copyWith(
        color: ref.color.onBackground,
        fontSize: 80,
      ),
    );
  }
}
