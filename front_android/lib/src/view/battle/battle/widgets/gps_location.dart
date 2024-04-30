import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:location/location.dart';

class GpsLocation extends ConsumerStatefulWidget {
  const GpsLocation({super.key});

  @override
  ConsumerState<GpsLocation> createState() => _LocationState();
}

class _LocationState extends ConsumerState<GpsLocation> {
  final Location location = Location();

  LocationData? _locationData;
  Duration? _time;
  StreamSubscription<LocationData>? _locationSubscription;
  String? _error;

  Future<void> _listenLocation() async {
    location.changeSettings(interval: 500);
    _time = Duration.zero;

    _locationSubscription =
        location.onLocationChanged.handleError((dynamic err) {
      if (err is PlatformException) {
        setState(() {
          _error = err.code;
        });
      }
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((currentLocation) {
      setState(() {
        _error = null;

        _locationData = currentLocation;
      });
    });
    setState(() {});
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
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _locationData.toString(),
      style: ref.typo.headline1.copyWith(
        color: ref.color.onBackground,
      ),
    );
  }
}
