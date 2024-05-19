import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class PaceCalorie extends ConsumerWidget {
  const PaceCalorie({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.avgPace,
              style: ref.typo.subTitle3.copyWith(
                color: ref.color.inactive,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  viewModel.avgPace.toString(),
                  style: ref.typo.subTitle2.copyWith(
                    color: ref.color.onBattleBox,
                    fontSize: 55,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 12),
                //   child: Text(
                //     ' min/km',
                //     style: ref.typo.body1.copyWith(
                //       color: ref.color.inactive,
                //     ),
                //   ),
                // )
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.calorieBurn,
              style: ref.typo.subTitle3.copyWith(
                color: ref.color.inactive,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  viewModel.calorie,
                  style: ref.typo.subTitle2.copyWith(
                    color: ref.color.onBattleBox,
                    fontSize: 55,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'kcal',
                    style: ref.typo.body1.copyWith(
                      color: ref.color.inactive,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
