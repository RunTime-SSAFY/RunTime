import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class AchievementAnimatedProgressBar extends ConsumerWidget {
  final double goal;
  final double prevGoal;
  final double current;

  const AchievementAnimatedProgressBar({
    required this.prevGoal,
    required this.goal,
    required this.current,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 현재 진행률 계산
    double percentage;

    if (current <= prevGoal) {
      percentage = 0;
    } else if (current >= goal) {
      percentage = 100;
    } else {
      percentage = (current - prevGoal) / (goal - prevGoal) * 100;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: percentage),
      duration: const Duration(milliseconds: 1000),
      builder: (BuildContext context, double value, Widget? child) {
        return Container(
          alignment: Alignment.centerLeft,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            widthFactor: value / 100,
            child: Container(
              decoration: BoxDecoration(
                color: ref.palette.yellow400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
