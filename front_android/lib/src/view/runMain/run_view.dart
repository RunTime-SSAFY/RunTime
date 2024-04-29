import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/theme/components/app_icon.dart';
import 'package:front_android/src/theme/components/bottom_navigation.dart';
import 'package:front_android/src/theme/components/png_image.dart';
import 'package:front_android/src/view/runMain/widgets/battle_mode_button.dart';
import 'package:front_android/src/view/runMain/widgets/run_main_button.dart';
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
              'bell',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: PngImage(
                'trackImage',
                size: MediaQuery.of(context).size.width,
              ),
            ),
            const Positioned(
              top: 370,
              left: 0,
              child: PngImage(
                'main_run_image',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const BattleModeButton(),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Expanded(
                      child: RunMainButton(
                        S.current.ranking,
                        RoutePath.ranking,
                        ref.color.rankingButton,
                      ),
                    )
                  ],
                ),
                const Spacer()
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
