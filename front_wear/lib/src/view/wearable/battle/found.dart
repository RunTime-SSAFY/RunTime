import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_wear/src/view/wearable/battle/battle_wait.dart';

class LookingFor extends ConsumerWidget {
  const LookingFor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const BattleWait(
      comments: '상대를 찾았습니다',
      
    );
  }
}
