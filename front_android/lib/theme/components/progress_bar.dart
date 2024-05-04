import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.currentProgress,
    required this.fullProgress,
    required this.valueColor,
    this.backgroundColor = Colors.grey,
    this.flipHorizontally = false,
  });

  final double currentProgress;
  final double fullProgress;
  final Color valueColor;
  final Color backgroundColor;
  final bool flipHorizontally;

  @override
  Widget build(BuildContext context) {
    double progress = currentProgress / fullProgress;
    return Transform.scale(
      scale: flipHorizontally ? -1 : 1,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 10,
        width: double.infinity,
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
