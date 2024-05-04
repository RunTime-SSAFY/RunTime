import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/src/view/battle/widgets/battle_time.dart';
import 'package:front_android/src/view/battle/widgets/cover_message.dart';
import 'package:front_android/src/view/battle/widgets/distance.dart';
import 'package:front_android/src/view/battle/widgets/pace_calory.dart';
import 'package:front_android/src/view/battle/widgets/unity.dart';
import 'package:front_android/theme/components/battle_background.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Battle extends ConsumerWidget {
  const Battle({super.key});

  // 주석: 배틀 시작할 떄 달릴 거리 전역에서 가져오기

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewProvider);
    // final args = ModalRoute.of(context)!.settings.arguments
    //     as Map<RouteParameter, dynamic>;
    // viewModel.targetDistance = args[RouteParameter.targetDistance];

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        viewModel.onGiveUp(context);
      },
      child: BattleBackground(
        child: Column(
          children: [
            const Distance(),
            const BattleTime(),
            const SizedBox(height: 20),
            const Unity(),
            const SizedBox(height: 20),
            const PaceCalory(),
            const SizedBox(height: 20),
            const CoverMessage(),
            const SizedBox(height: 30),
            Button(
              onPressed: () => viewModel.onGiveUp(context),
              text: S.current.giveUp,
              backGroundColor: ref.color.deny,
              fontColor: ref.color.onDeny,
            )
          ],
        ),
      ),
    );
  }
}
