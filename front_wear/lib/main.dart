import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('디지털 시계'),
        ),
        body: const ClockScreen(),
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
  final String _currentDate = '';

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
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
