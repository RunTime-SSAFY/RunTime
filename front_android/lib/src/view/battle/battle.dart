import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/widgets/battleLayout.dart';
import 'package:front_android/src/view/battle/widgets/gps/gps_location.dart';
import 'package:front_android/src/view/battle/widgets/running_information/running_impormation.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Battle extends ConsumerWidget {
  const Battle({super.key});

  // 주석: 배틀 시작할 떄 달릴 거리 전역에서 가져오기

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BattleLayout(
      child: Column(
        children: [
          const GpsLocation(
            distance: 3,
          ),
          const RunningInformation(),
          Button(
            onPressed: () {},
            text: S.current.giveUp,
            backGroundColor: ref.color.deny,
            fontColor: ref.color.onDeny,
          )
        ],
      ),
    );
  }
}
