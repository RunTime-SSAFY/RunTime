import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/theme/components/app_icon.dart';
import 'package:front_android/src/view/runMain/widget/battle_mode_button.dart';
import 'package:front_android/src/view/runMain/widget/run_main_button.dart';
import 'package:front_android/util/route_path.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const BattleModeButton(),
            Row(
              children: [
                Expanded(
                  child: RunMainButton(
                    '사용자 모드',
                    RoutePath.userMode,
                    ref.color.userMode,
                  ),
                ),
                Expanded(
                  child: RunMainButton(
                    '연습 모드',
                    RoutePath.practiceMode,
                    ref.color.practiceMode,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
