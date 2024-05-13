import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class AchievementAnimatedProgressBar extends ConsumerWidget {
  final double goal;
  final double current;

  const AchievementAnimatedProgressBar({
    required this.goal,
    required this.current,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double percentage = (current / goal) * 100;

    return Expanded(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: percentage),
        duration: const Duration(milliseconds: 1000),
        builder: (BuildContext context, double value, Widget? child) {
          return Container(
            alignment: Alignment.centerLeft,
            height: 12,
            margin: const EdgeInsets.only(left: 10),
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
      ),
    );
  }
}
