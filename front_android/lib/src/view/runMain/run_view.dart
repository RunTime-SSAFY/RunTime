import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/runMain/widgets/battle_mode_button.dart';
import 'package:front_android/src/view/runMain/widgets/run_main_button.dart';
import 'package:front_android/theme/components/bottom_navigation.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';

class RunMainView extends ConsumerWidget {
  const RunMainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                  'assets/images/background/runMainBackground.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            S.current.running,
            style: ref.typo.appBarTitle,
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: SvgIcon(
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
                bottom: min(-MediaQuery.of(context).size.height / 10, -180),
                child: const PngImage(
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
                          modeName: S.current.userMode,
                          modeRoute: RoutePath.userMode,
                          color: ref.color.userMode,
                        ),
                      ),
                      Expanded(
                        child: RunMainButton(
                          modeName: S.current.practiceMode,
                          modeRoute: RoutePath.practiceMode,
                          color: ref.color.practiceMode,
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
                          modeName: S.current.ranking,
                          modeRoute: RoutePath.ranking,
                          color: ref.color.rankingButton,
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
      ),
    );
  }
}
