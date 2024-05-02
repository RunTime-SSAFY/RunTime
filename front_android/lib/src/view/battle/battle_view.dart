import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/src/view/battle/widgets/battle_time.dart';
import 'package:front_android/src/view/battle/widgets/gps_location/distance.dart';
import 'package:front_android/src/view/battle/widgets/running_information/running_information.dart';
import 'package:front_android/theme/components/battle_background.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Battle extends ConsumerWidget {
  const Battle({super.key});

  // 주석: 배틀 시작할 떄 달릴 거리 전역에서 가져오기

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewProvider);
    return PopScope(
      onPopInvoked: (didPop) {},
      child: BattleBackground(
        child: Column(
          children: [
            const DistanceTime(
              distance: 3,
            ),
            const BattleTime(),
            const RunningInformation(),
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
