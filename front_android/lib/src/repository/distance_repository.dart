import 'dart:async';

import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/stomp_repository.dart';
import 'package:geolocator/geolocator.dart';

class DistanceRepository {
  final StompRepository socket;
  final String sendDestination;
  final int roomId;

  DistanceRepository({
    required this.socket,
    required this.sendDestination,
    required this.roomId,
  });

  int index = 1;

  StreamSubscription<Position>? _positionStream;
  Position? lastPosition;
  double _currentDistance = 0;
  double get currentDistance => _currentDistance;

  bool get isNotListening => _positionStream == null;
  double instantaneousVelocity = 0;
  late double _distanceBetween;
  bool reenter = false;

  Future<void> listenLocation() async {
    lastPosition = await Geolocator.getCurrentPosition();
    LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      intervalDuration: const Duration(seconds: 1),
      forceLocationManager: true,
    );
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        _distanceBetween = Geolocator.distanceBetween(lastPosition!.latitude,
            lastPosition!.longitude, position.latitude, position.longitude);
        lastPosition = position;
        // 부동소수점 오차 제거
        _currentDistance =
            (_currentDistance * 10000 + _distanceBetween * 10000) / 10000;
        instantaneousVelocity = _distanceBetween * 2 * 36 / 10;

        socket.send(
          destination: sendDestination,
          body: BattleSocketData(
            position: position,
            currentDistance: _currentDistance,
            index: index,
            roomId: roomId,
            reenter: reenter,
          ).toJson(),
        );
        index++;
      }
    });
  }

  void cancelListen() {
    _positionStream?.cancel();
  }
}
