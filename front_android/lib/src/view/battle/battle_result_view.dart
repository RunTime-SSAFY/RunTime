import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/src/view/battle/widgets/result_box.dart';
import 'package:front_android/theme/components/battle_background.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class BattleResultView extends ConsumerWidget {
  const BattleResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);

    return BattleBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.result ? S.current.win : S.current.lose,
                  style: ref.typo.mainTitle.copyWith(
                    color: ref.color.onBackground,
                  ),
                ),
                Text(
                  '${S.current.rankPoint} ${viewModel.point}',
                  style: ref.typo.subTitle1.copyWith(
                    color: ref.color.onBackground,
                  ),
                ),
              ],
            ),
          ),
          PngImage(
            viewModel.character,
            size: 300,
          ),
          const ResultBox(),
          const Spacer(),
          Button(
            onPressed: () => viewModel.onResultDone(context),
            text: S.current.done,
            backGroundColor: ref.color.accept,
            fontColor: ref.color.onAccept,
          )
        ],
      ),
    );
  }
}
