import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:geolocator/geolocator.dart';

final distanceServiceProvider =
    ChangeNotifierProvider((ref) => DistanceService());

class DistanceService with ChangeNotifier {
  DistanceService();

  StreamSubscription<Position>? _positionStream;
  late Position _lastPosition;
  double _distanceNow = 0;
  String get distanceNow => _distanceNow.toKilometer();

  final DateTime _startTime = DateTime.now().add(const Duration(seconds: 4));
  DateTime get startTime => _startTime;

  DateTime _currentTime = DateTime.now();

  DateTime get currentTime => _currentTime;

  void timer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
    });
  }

  Future<void> listenLocation() async {
    _lastPosition = await Geolocator.getCurrentPosition();
    LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      intervalDuration: const Duration(milliseconds: 500),
      forceLocationManager: true,
    );
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      print(position.toString());
      print('현재까지 달린 거리: $distanceNow');
      notifyListeners();
      if (position != null) {
        _distanceNow += Geolocator.distanceBetween(_lastPosition.latitude,
            _lastPosition.longitude, position.latitude, position.longitude);
        _lastPosition = position;

        // 주석: 소켓으로 서버에 정보 보내기
      }
    });
  }

  void stopListen() {
    _positionStream?.cancel();
  }
}
