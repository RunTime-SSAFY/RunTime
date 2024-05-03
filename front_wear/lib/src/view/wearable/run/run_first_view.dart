import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RunFirstView extends ConsumerWidget {
  const RunFirstView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/image/hedgehog.png'),
          const DistanceScreen(),
        ],
      ),
    );
  }
}

class DistanceScreen extends ConsumerStatefulWidget {
  const DistanceScreen({super.key});

  @override
  _DistanceScreenState createState() => _DistanceScreenState();
}

class _DistanceScreenState extends ConsumerState<DistanceScreen> {
  double _currentDistance = 0.0;

  @override
  void initState() {
    //임시로 값넣음
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentDistance = _currentDistance + 0.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_currentDistance.toStringAsFixed(2)}' ' km',
            style: const TextStyle(
              backgroundColor: Colors.blue,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
