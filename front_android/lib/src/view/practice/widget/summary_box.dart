import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/practice/practice_view_model.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:intl/intl.dart';

class SummaryBox extends ConsumerWidget {
  const SummaryBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PracticeViewModel viewModel = ref.read(practiceViewModelProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ref.color.battleBox,
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    viewModel.distance,
                    style: ref.typo.subTitle1.copyWith(
                      color: ref.color.onBattleBox,
                      fontSize: 45,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd(
                            Localizations.localeOf(context).toString())
                        .format(viewModel.date),
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
                    viewModel.pace,
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
                    S.current.calorieBurn,
                    style: ref.typo.body1.copyWith(
                      color: ref.color.inactive,
                    ),
                  ),
                  Text(
                    viewModel.calorie,
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
