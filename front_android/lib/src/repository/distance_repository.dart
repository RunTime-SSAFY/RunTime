import 'dart:async';

import 'package:geolocator/geolocator.dart';

class DistanceRepository {
  DistanceRepository() {
    listenLocation();
  }

  StreamSubscription<Position>? _positionStream;
  late Position _lastPosition;
  double _distanceNow = 0;
  double get distanceNow => _distanceNow;

  bool get isNotListening => _positionStream == null;

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
      if (position != null) {
        _distanceNow += Geolocator.distanceBetween(_lastPosition.latitude,
            _lastPosition.longitude, position.latitude, position.longitude);
        _lastPosition = position;

        // 주석: 소켓으로 서버에 정보 보내기
      }
    });
  }

  void cancelListen() {
    _positionStream?.cancel();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
  }
}
