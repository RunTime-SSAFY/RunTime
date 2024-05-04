import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/theme/components/progress_bar.dart';

class RunBar extends ConsumerWidget {
  const RunBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);

    return ProgressBar(
      currentProgress: viewModel.currentDistance,
      fullProgress: viewModel.targetDistance,
      valueColor: ref.color.trace,
      backgroundColor: ref.color.traceBackground,
    );
  }
}
