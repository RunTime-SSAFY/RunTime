import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle/service/extension.dart';
import 'package:geolocator/geolocator.dart';

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
  final DateTime _startTime = DateTime.now();
  StreamSubscription<Position>? _positionStream;
  final DateTime _time = DateTime.now();
  late Position _lastPosition;
  double _distanceNow = 0;

  Future<void> _listenLocation() async {
    _lastPosition = await Geolocator.getCurrentPosition();
    LocationSettings locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 2,
      intervalDuration: const Duration(microseconds: 500),
      forceLocationManager: true,
    );
    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      debugPrint(_distanceNow.toString());
      if (position != null) {
        setState(() {
          _distanceNow += Geolocator.distanceBetween(_lastPosition.latitude,
              _lastPosition.longitude, position.latitude, position.longitude);
          _lastPosition = position;
        });
      }
    });
  }

  // Future<void> _stopListen() async {
  //   await _locationSubscription?.cancel();
  //   setState(() {
  //     _locationSubscription = null;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _listenLocation();
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _distanceNow.toKilometer(),
              style: ref.typo.headline1.copyWith(
                color: ref.color.onBackground,
                fontSize: 60,
              ),
            ),
            Text(
              ' / ${widget.distance}km',
              style: ref.typo.body1.copyWith(
                color: ref.color.onBackground,
                fontSize: 40,
              ),
            ),
          ],
        ),
        Text(
          _time.difference(_startTime).toHhMmSs(),
          style: ref.typo.mainTitle.copyWith(
            color: ref.color.onBackground,
            fontSize: 60,
          ),
        )
      ],
    );
  }
}
