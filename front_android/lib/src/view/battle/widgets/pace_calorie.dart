import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/theme/components/text_clip_horizontal.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class PaceCalorie extends ConsumerWidget {
  const PaceCalorie({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.avgPace,
                style: ref.typo.subTitle3.copyWith(
                  color: ref.palette.gray600,
                ),
              ),
              TextClipHorizontal(
                clipFactor: 0.68,
                alignment: Alignment.centerLeft,
                child: Text(
                  viewModel.avgPace.toString(),
                  style: ref.typo.subTitle2.copyWith(
                    color: ref.color.onBattleBox,
                    fontSize: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.calorieBurn,
                style: ref.typo.subTitle3.copyWith(
                  color: ref.palette.gray600,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextClipHorizontal(
                    clipFactor: 0.68,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      viewModel.calorie,
                      style: ref.typo.subTitle2.copyWith(
                        color: ref.color.onBattleBox,
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Text(
                    'kcal',
                    style: ref.typo.body1.copyWith(
                      fontSize: 24,
                      color: ref.palette.gray400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
