import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle_view_model.dart';
import 'package:front_android/src/view/battle/widgets/battle_time.dart';
import 'package:front_android/src/view/battle/widgets/count_down.dart';
import 'package:front_android/src/view/battle/widgets/distance.dart';
import 'package:front_android/src/view/battle/widgets/google_map.dart';
import 'package:front_android/src/view/battle/widgets/pace_calorie.dart';
import 'package:front_android/src/view/battle/widgets/run_bar.dart';
import 'package:front_android/theme/components/battle_background.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/circular_indicator.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Battle extends ConsumerStatefulWidget {
  const Battle({super.key});

  // 주석: 배틀 시작할 떄 달릴 거리 전역에서 가져오기

  @override
  ConsumerState<Battle> createState() => _BattleState();
}

class _BattleState extends ConsumerState<Battle> {
  OverlayEntry? _countDownOverlay;
  late bool moved;
  // 초기 GPS 접근 시간 확보
  void _showOverlay() {
    _countDownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  ref.color.battleBackground1,
                  ref.color.battleBackground2,
                ],
              ),
            ),
            child: const CountDown(),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_countDownOverlay!);

    Future.delayed(const Duration(seconds: 4), () {
      _countDownOverlay?.remove();
      _countDownOverlay = null;
    });
  }

  @override
  void initState() {
    super.initState();
    moved = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
  }

  @override
  Widget build(BuildContext context) {
    BattleViewModel viewModel = ref.watch(battleViewModelProvider);
    if (viewModel.currentDistance > viewModel.targetDistance && !moved) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        viewModel.distanceService.cancelListen();
        viewModel.stopCamera = true;
        await viewModel.captureImage();
        if (!context.mounted) return;
        viewModel.onBattleDone(context);
      });
      moved = true;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        viewModel.onGiveUp(context);
      },
      child: BattleBackground(
        child: Stack(
          children: [
            Column(
              children: [
                const Distance(),
                const BattleTime(),
                const SizedBox(height: 20),
                const RunBar(),
                const SizedBox(height: 20),
                const PaceCalorie(),
                const SizedBox(height: 20),
                const Map(),
                const SizedBox(height: 30),
                Button(
                  onPressed: () => viewModel.onGiveUp(context),
                  text: S.current.giveUp,
                  backGroundColor: ref.color.deny,
                  fontColor: ref.color.onDeny,
                ),
              ],
            ),
            if (viewModel.cameraMoving)
              CircularIndicator(
                isLoading: viewModel.cameraMoving,
                backgroundColor: ref.color.black,
              ),
          ],
        ),
      ),
    );
  }
}
