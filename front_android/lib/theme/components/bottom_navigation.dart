import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 내비게이션 인덱스 프로바이더 등록
    final int currentIndex = ref.watch(currentIndexProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: S.current.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.article_outlined),
          activeIcon: const Icon(Icons.article),
          label: S.current.achievement,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.star_border_outlined),
          activeIcon: const Icon(Icons.star),
          label: S.current.character,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.timer_outlined),
          activeIcon: const Icon(Icons.timer),
          label: S.current.record,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle_outlined),
          activeIcon: const Icon(Icons.account_circle),
          label: S.current.profile,
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: ref.color.accept,
      // 클릭 시, 스테이트 변경
      onTap: (index) {
        ref.read(currentIndexProvider.notifier).update((state) => index);
        switch (index) {
          case 0:
            context.go(RoutePathHelper.runMain);
          case 1:
            context.go(RoutePathHelper.achievement);
          case 2:
            context.go(RoutePathHelper.character);
          case 3:
            context.go(RoutePathHelper.record);
          case 4:
            context.go(RoutePathHelper.profile);
        }
      },
    );
  }
}
