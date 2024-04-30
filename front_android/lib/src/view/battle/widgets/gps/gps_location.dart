import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/service/extension.dart';
import 'package:front_android/src/view/battle/widgets/counter.dart';
import 'package:geolocator/geolocator.dart';

part 'distance_time.dart';

class GpsLocation extends ConsumerStatefulWidget {
  const GpsLocation({
    required this.distance,
    super.key,
  });

  final int distance;

  @override
  ConsumerState<GpsLocation> createState() => _LocationState();
}

class _LocationState extends ConsumerState<GpsLocation> {
  StreamSubscription<Position>? _positionStream;
  late Position _lastPosition;
  double distanceNow = 0;
  DateTime startTime = DateTime.now().add(const Duration(seconds: 4));
  DateTime currentTime = DateTime.now();

  void timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  OverlayEntry? _countDownOverlay;

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

  Future<void> _listenLocation() async {
    _lastPosition = await Geolocator.getCurrentPosition();
    LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 3,
      intervalDuration: const Duration(microseconds: 500),
      forceLocationManager: true,
    );
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      debugPrint(distanceNow.toString());
      if (position != null) {
        setState(() {
          distanceNow += Geolocator.distanceBetween(_lastPosition.latitude,
              _lastPosition.longitude, position.latitude, position.longitude);
          _lastPosition = position;
        });
        // 주석: 소켓으로 서버에 정보 보내기
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showOverlay());
    _listenLocation();
    timer();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    setState(() {
      _positionStream = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DistanceTime(
      distanceNow: distanceNow,
      distance: widget.distance,
      startTime: startTime,
      currentTime: currentTime,
    );
  }
}
