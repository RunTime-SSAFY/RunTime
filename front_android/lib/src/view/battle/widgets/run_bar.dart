import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
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
            height: 90,
            child: Stack(
              children: List.generate(viewModel.participants.length, (index) {
                return Positioned(
                  left: viewModel.participants[index].distance /
                      viewModel.targetDistance *
                      (screenWidth - 50),
                  child: SizedBox(
                    width: 50,
                    height: 80,
                    child: Column(
                      children: [
                        FittedBox(
                          child: Text(
                            viewModel.participants[index].nickname,
                            style: ref.typo.subTitle5.copyWith(
                              color: ref.color.onBackground,
                            ),
                          ),
                        ),
                        Image.network(
                          viewModel.participants[index].characterImgUrl,
                          height: 50,
                          fit: BoxFit.fitHeight,
                        )
                      ],
                    ),
                  ),
                );
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
