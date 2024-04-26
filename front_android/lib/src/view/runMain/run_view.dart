import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/theme/components/app_icon.dart';
import 'package:front_android/src/view/runMain/widget/battle_mode_button.dart';

class RunMainView extends ConsumerWidget {
  const RunMainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '달리기',
          style: ref.typo.appBarTitle,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: AppIcon(
              icon: 'bell',
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            BattleModeButton(),
            Row(
              children: [
                // RunMainButton(),
                // RunMainButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
