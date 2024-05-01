import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_android/src/view/battle/widgets/running_information/battle_message.dart';
import 'package:front_android/src/view/battle/widgets/running_information/pace_calory.dart';
import 'package:front_android/src/view/battle/widgets/running_information/running_unity.dart';

class RunningInformation extends StatelessWidget {
  const RunningInformation({super.key});

  // 소켓으로 나와 상대의 거리 정보 가져오기
  // RunningUnity: 나와 상대의 거리
  // PaceCalory: 나의 거리
  // BattleMessage: 나의 거리

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: RunningUnity(),
          ),
          Row(
            children: [Text('cd'), Text('fwa')],
          ),
          Expanded(
            flex: 1,
            child: PaceCalory(),
          ),
          Text('dwa'),
          Expanded(
            flex: 3,
            child: BattleMessage(),
          ),
        ],
      ),
    );
  }
}
