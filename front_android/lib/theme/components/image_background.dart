import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Scaffold backgroundColor: Colors.transparent적용 필수
// appBar를 사용할 경우 appBar의 backgroundColor: Colors.transparent적용
class BattleImageBackground extends ConsumerWidget {
  const BattleImageBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/battleBackground.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: child,
    );
  }
}
