import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Image.asset('assets/image/hedgehog.png'),
            const ClockScreen(),
          ],
        ),
      ),
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    // 1초 마다 현재 시간을 업데이트
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime =
            DateFormat('yyyy-MM-dd (E)\nHH:mm:ss').format(DateTime.now());
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
            _currentTime,
            style: const TextStyle(
              backgroundColor: Colors.yellow,
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
