import 'package:flutter/material.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: S.current.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.article_outlined),
          label: S.current.achievement,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.verified),
          label: S.current.character,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.timer),
          label: S.current.record,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle_rounded),
          label: S.current.profile,
        ),
      ],
    );
  }
}
