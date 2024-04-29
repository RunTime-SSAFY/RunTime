import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/theme/components/app_icon.dart';
import 'package:front_android/src/theme/components/bottom_navigation.dart';
import 'package:front_android/src/theme/components/png_image.dart';
import 'package:front_android/src/view/runMain/widget/battle_mode_button.dart';
import 'package:front_android/src/view/runMain/widget/run_main_button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';

class RunMainView extends ConsumerWidget {
  const RunMainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.running,
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
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: RunMainButton(
                    S.current.userMode,
                    RoutePath.userMode,
                    ref.color.userMode,
                  ),
                ),
                Expanded(
                  child: RunMainButton(
                    S.current.practiceMode,
                    RoutePath.practiceMode,
                    ref.color.practiceMode,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: PngImage(image: 'main_run_image')),
                Expanded(
                  child: RunMainButton(
                    S.current.ranking,
                    RoutePath.ranking,
                    ref.color.rankingButton,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
