import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/view/battle/battleMatching/battle_matching.dart';

class BattleView extends ConsumerWidget {
  const BattleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: BattleMatchingView(),
    );
  }
}
