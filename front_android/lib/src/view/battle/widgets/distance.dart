import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/util/helper/extension.dart';

class Distance extends ConsumerStatefulWidget {
  const Distance({
    super.key,
  });

  @override
  ConsumerState<Distance> createState() => _DistanceTimeState();
}

class _DistanceTimeState extends ConsumerState<Distance> {
  @override
  Widget build(BuildContext context) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          viewModel.currentDistance.toKilometer(),
          style: ref.typo.headline1.copyWith(
            color: ref.color.onBackground,
            fontSize: 60,
          ),
        ),
        Text(
          ' / ${viewModel.targetDistance}m',
          style: ref.typo.body1.copyWith(
            color: ref.color.onBackground,
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}
