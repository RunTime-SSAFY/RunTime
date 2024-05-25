import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/achievement/achievement_view_model.dart';
import 'package:front_android/src/view/achievement/widgets/achievement_list.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class AchievementView extends ConsumerStatefulWidget {
  const AchievementView({super.key});

  @override
  ConsumerState<AchievementView> createState() => _AchievementViewState();
}

class _AchievementViewState extends ConsumerState<AchievementView> {
  late AchievementViewModel viewModel;
  late ConfettiController _confettiController;
  @override
  void initState() {
    super.initState();
    // 위젯 빌드 후 실행(viewModel 받와야 사용 가능)

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.clearAchievementList();
      viewModel.fetchAchievementList();
      print(viewModel.achievementList);

      _confettiController = ConfettiController(
        duration: const Duration(seconds: 10),
      );
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(achievementProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.achievement,
          style: ref.typo.appBarMainTitle,
        ),
      ),
      body: AchievementList(
        confettiController: _confettiController,
        achievementList: viewModel.achievementList,
        achievementCount: viewModel.achievementCount,
      ),
    );
  }
}
