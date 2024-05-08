import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class BottomNavigationWidget extends ConsumerWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int currentIndex = ref.watch(bottomNavigationProvider);

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
    );
  }
}

final bottomNavigationProvider = StateProvider<int>((ref) => 0);
