import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/theme/components/progress_bar.dart';

class RunBar extends ConsumerWidget {
  const RunBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Stack(
              children: List.generate(viewModel.participants.length, (index) {
                Widget myNickname;
                if (viewModel.participants[index].nickname ==
                    UserService.instance.nickname) {
                  myNickname = Text(
                    UserService.instance.nickname,
                    style: ref.typo.body1.copyWith(
                      color: ref.color.onBackground,
                    ),
                  );
                } else {
                  myNickname = Container();
                }
                return Positioned(
                    left: viewModel.participants[index].distance /
                        viewModel.targetDistance *
                        (screenWidth - 200),
                    child: Column(
                      children: [
                        myNickname,
                        Image.network(
                          viewModel.participants[index].characterImgUrl,
                          height: 80,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/mainCharacter.gif',
                              fit: BoxFit.contain,
                              height: 80,
                              width: 100,
                            );
                          },
                        ),
                      ],
                    ));
              }),
            ),
          ),
          ProgressBar(
            currentProgress: viewModel.currentDistance,
            fullProgress: viewModel.targetDistance,
            valueColor: ref.color.trace,
            backgroundColor: ref.color.traceBackground,
          ),
        ],
      ),
    );
  }
}
