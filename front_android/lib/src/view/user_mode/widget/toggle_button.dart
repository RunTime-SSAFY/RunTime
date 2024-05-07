import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class ToggleButton extends ConsumerWidget {
  const ToggleButton({
    super.key,
    required this.isPublic,
  });

  final bool isPublic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: ref.color.userModeBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isPublic ? ref.color.battleMode2 : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                S.current.publicRoom,
                style: ref.typo.subTitle3.copyWith(
                  color: !isPublic
                      ? ref.color.onBackground
                      : ref.color.onBattleBox,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: !isPublic ? ref.color.battleMode2 : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                S.current.privateRoom,
                style: ref.typo.subTitle3.copyWith(
                  color: !isPublic
                      ? ref.color.onBackground
                      : ref.color.onBattleBox,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
