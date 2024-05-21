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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: List.generate(viewModel.participants.length, (index) {
              Widget myLocation;
              if (viewModel.participants[index].nickname ==
                  UserService.instance.nickname) {
                myLocation = Transform.flip(
                  flipY: true,
                  child: Icon(
                    Icons.navigation_rounded,
                    size: 24,
                    color: ref.color.deny,
                  ),
                );
              } else {
                myLocation = const SizedBox(height: 20);
              }
              return Positioned(
                  left: viewModel.participants[index].distance /
                      viewModel.targetDistance *
                      (screenWidth - 200),
                  child: Column(
                    children: [
                      myLocation,
                      Image.network(
                        viewModel.participants[index].characterImgUrl,
                        height: viewModel.participants[index].nickname ==
                                UserService.instance.nickname
                            ? 80
                            : 60,
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
    );
  }
}
