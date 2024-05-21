import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/theme/components/text_clip_horizontal.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/helper/number_format_helper.dart';

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
        TextClipHorizontal(
          clipFactor: 0.86,
          child: Row(
            children: [
              Text(
                NumberFormatHelper.floatTrunk(viewModel.currentDistance / 1000),
                style: ref.typo.body1.copyWith(
                  // fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w200,
                  color: ref.color.onBackground,
                  fontSize: 60,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
        Text(
          ' / ${NumberFormatHelper.floatTrunk(viewModel.targetDistance / 1000)}km',
          style: ref.typo.body1.copyWith(
            // fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w200,
            color: ref.color.onBackground,
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}
