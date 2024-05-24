import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/user_mode/user_mode_view_model.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class ToggleButton extends ConsumerWidget {
  const ToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModeViewModel viewModel = ref.watch(userModeViewModelProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: ref.color.userModeBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  viewModel.setIsPrivateRoom(true);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: viewModel.isPrivateRoom
                        ? ref.color.battleMode2
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    S.current.publicRoom,
                    style: ref.typo.subTitle3.copyWith(
                      color: !viewModel.isPrivateRoom
                          ? ref.color.onBackground
                          : ref.color.onBattleBox,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  viewModel.setIsPrivateRoom(false);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: !viewModel.isPrivateRoom
                        ? ref.color.battleMode2
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    S.current.privateRoom,
                    style: ref.typo.subTitle3.copyWith(
                      color: !viewModel.isPrivateRoom
                          ? ref.color.onBackground
                          : ref.color.onBattleBox,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
