import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle/widgets/battle_message.dart';
import 'package:front_android/src/view/battle/battle/widgets/gps_location.dart';
import 'package:front_android/src/view/battle/widgets/battleLayout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Battle extends ConsumerWidget {
  const Battle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BattleLayout(
      child: Column(
        children: [
          const GpsLocation(
            distance: 3,
          ),
          const Expanded(child: Placeholder()),
          const Row(
            children: [Text('cd'), Text('fwa')],
          ),
          const Expanded(child: Placeholder()),
          const Text('dwa'),
          const BattleMessage(),
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
