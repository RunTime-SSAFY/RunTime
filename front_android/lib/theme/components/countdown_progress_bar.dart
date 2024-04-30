import 'dart:async';

import 'package:flutter/material.dart';

class CountdownProgressBar extends StatefulWidget {
  const CountdownProgressBar({
    super.key,
    required this.seconds,
    required this.valueColor,
    required this.handleTimeOver,
    this.backgroundColor = Colors.grey,
    this.flipHorizontally = false,
  });

  final int seconds;
  final Color valueColor;
  final Color backgroundColor;
  final bool flipHorizontally;
  final void Function() handleTimeOver;

  @override
  State<CountdownProgressBar> createState() => _CountdownProgressBarState();
}

class _CountdownProgressBarState extends State<CountdownProgressBar> {
  late Timer _timer;
  late int _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = widget.seconds * 1000;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_currentTime > 0) {
          _currentTime -= 50;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = _currentTime / (widget.seconds * 1000);
    if (_currentTime == 0) {
      widget.handleTimeOver();
      return const SizedBox();
    }
    return Transform.scale(
      scale: widget.flipHorizontally ? -1 : 1,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 10,
        width: double.infinity,
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: widget.backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(widget.valueColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
