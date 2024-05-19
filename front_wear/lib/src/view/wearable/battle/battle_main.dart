import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_wear/src/service/theme_service.dart';
import 'package:front_wear/src/view/wearable/battle/battle_wait.dart';
import 'package:front_wear/src/view/wearable/mode/button_screen.dart';

class BattleMain extends ConsumerWidget {
  const BattleMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonScreen(
      title: '배틀모드',
      color: ref.color.wBattleMode,
      btn: '상대찾기',
      nextPage: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BattleWait(
              comments: '상대를 찾는 중',
            ),
          ),
        );
        // 버튼 클릭시 수행할 액션
      },
    );
  }
}
