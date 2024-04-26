import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/theme/components/app_icon.dart';
import 'package:front_android/src/theme/components/png_image.dart';
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
            const Spacer(),
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
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: PngImage(image: 'main_run_image')),
                Expanded(
                  child: RunMainButton(
                    '랭킹',
                    RoutePath.ranking,
                    ref.color.rankingButton,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: '도전과제',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified),
            label: '캐릭터',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: '기록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
