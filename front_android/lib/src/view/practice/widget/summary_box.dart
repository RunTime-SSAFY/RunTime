import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/practice/practice_view_model.dart';
import 'package:front_android/theme/components/text_clip_horizontal.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:intl/intl.dart';

class SummaryBox extends ConsumerWidget {
  const SummaryBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PracticeViewModel viewModel = ref.read(practiceViewModelProvider);

    return AspectRatio(
      // 황금비율
      aspectRatio: 1.618,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ref.palette.gray800.withOpacity(0.5),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextClipHorizontal(
                      clipFactor: 0.64,
                      child: Text(
                        viewModel.distance,
                        style: ref.typo.subTitle1.copyWith(
                          color: ref.color.onBattleBox,
                          fontSize: 34,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat('yyyy. M. d. HH:mm').format(viewModel.date),
                      style: ref.typo.body1.copyWith(
                        fontSize: 12,
                        color: ref.palette.gray400,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    TextClipHorizontal(
                      child: Text(
                        S.current.avgPace,
                        style: ref.typo.body1.copyWith(
                          fontSize: 12,
                          color: ref.palette.gray400,
                        ),
                      ),
                    ),
                    TextClipHorizontal(
                      clipFactor: 0.7,
                      child: Text(
                        viewModel.pace,
                        style: ref.typo.subTitle1.copyWith(
                          color: ref.color.onBattleBox,
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    TextClipHorizontal(
                      child: Text(
                        S.current.calorieBurn,
                        style: ref.typo.body1.copyWith(
                          fontSize: 12,
                          color: ref.palette.gray400,
                        ),
                      ),
                    ),
                    TextClipHorizontal(
                      clipFactor: 0.7,
                      child: Text(
                        viewModel.calorie,
                        style: ref.typo.subTitle1.copyWith(
                          color: ref.color.onBattleBox,
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            // Text(
            //   S.current.runningTime,
            //   style: ref.typo.body1.copyWith(
            //     color: ref.palette.gray400,
            //   ),
            // ),
            // 달린 시간
            TextClipHorizontal(
              clipFactor: 0.7,
              alignment: Alignment.centerRight,
              child: Text(
                viewModel.runningTime,
                style: ref.typo.headline1.copyWith(
                  color: ref.color.onBattleBox,
                  fontSize: 50,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
