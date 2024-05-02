import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/widgets/count_down.dart';
import 'package:front_android/src/view/battle/widgets/gps_location/distance__service.dart';

class DistanceTime extends ConsumerStatefulWidget {
  const DistanceTime({
    required this.distance,
    super.key,
  });

  final int distance;

  @override
  ConsumerState<DistanceTime> createState() => _DistanceTimeState();
}

class _DistanceTimeState extends ConsumerState<DistanceTime> {
  OverlayEntry? _countDownOverlay;
  late DistanceService viewModel;

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(distanceServiceProvider);
    if (_countDownOverlay == null) {
      viewModel.listenLocation();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          viewModel.distanceNow,
          style: ref.typo.headline1.copyWith(
            color: ref.color.onBackground,
            fontSize: 60,
          ),
        ),
        Text(
          ' / ${widget.distance}km',
          style: ref.typo.body1.copyWith(
            color: ref.color.onBackground,
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}
