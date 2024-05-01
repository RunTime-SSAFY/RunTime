import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/widgets/gps_location/gps_location.dart';
import 'package:front_android/src/view/battle/widgets/running_information/running_information.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Battle extends ConsumerWidget {
  const Battle({super.key});

  // 주석: 배틀 시작할 떄 달릴 거리 전역에서 가져오기

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ref.color.battleBackground1,
            ref.color.battleBackground2,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
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
        ),
      ),
    );
  }
}
