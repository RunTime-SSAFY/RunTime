import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class ResultBox extends ConsumerWidget {
  const ResultBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ref.color.battleBox,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    viewModel.targetDistance.toKilometer(),
                    style: ref.typo.subTitle1.copyWith(
                      color: ref.color.onBattleBox,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    viewModel.date,
                    style: ref.typo.body1.copyWith(
                      color: ref.color.inactive,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    S.current.avgPace,
                    style: ref.typo.body1.copyWith(
                      color: ref.color.inactive,
                    ),
                  ),
                  Text(
                    viewModel.avgPace.toString(),
                    style: ref.typo.subTitle1.copyWith(
                      color: ref.color.onBattleBox,
                      fontSize: 35,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    S.current.caloryBurn,
                    style: ref.typo.body1.copyWith(
                      color: ref.color.inactive,
                    ),
                  ),
                  Text(
                    viewModel.calory,
                    style: ref.typo.subTitle1.copyWith(
                      color: ref.color.onBattleBox,
                      fontSize: 35,
                    ),
                  )
                ],
              )
            ],
          ),
          Text(
            S.current.runningTime,
            style: ref.typo.body1.copyWith(
              color: ref.color.inactive,
            ),
          ),
          Text(
            viewModel.runningTime,
            style: ref.typo.headline1.copyWith(
              color: ref.color.onBattleBox,
              fontSize: 60,
            ),
          )
        ],
      ),
    );
  }
}
