import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/src/view/battle/widgets/result_box.dart';
import 'package:front_android/theme/components/battle_background.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/circular_indicator.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class BattleResultView extends ConsumerStatefulWidget {
  const BattleResultView({super.key});

  @override
  ConsumerState<BattleResultView> createState() => _BattleResultViewState();
}

class _BattleResultViewState extends ConsumerState<BattleResultView> {
  late BattleViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.distanceService.cancelListen();
      viewModel.getResult();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(battleViewModelProvider);

    return Stack(
      children: [
        BattleBackground(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.result,
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
              Image.network(
                viewModel.character,
                height: 300,
                width: 300,
                fit: BoxFit.contain,
              ),
              const ResultBox(),
              const Spacer(),
              Button(
                onPressed: () => viewModel.onResultDone(context),
                text: S.current.done,
                backGroundColor: ref.color.accept,
                fontColor: ref.color.onAccept,
              ),
            ],
          ),
        ),
        if (viewModel.isLoading)
          CircularIndicator(
            isLoading: viewModel.isLoading,
            backgroundColor: ref.color.black,
          ),
      ],
    );
  }
}
