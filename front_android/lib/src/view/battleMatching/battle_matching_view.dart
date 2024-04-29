import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class BattleMatchingView extends ConsumerWidget {
  const BattleMatchingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          'ㅎㅇ',
          style: ref.typo.appBarTitle,
        ),
      ),
    );
  }
}
