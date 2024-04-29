```
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class ListenLocation extends StatefulWidget {
  const ListenLocation({super.key});

  @override
  State<ListenLocation> createState() => _ListenLocationState();
}

class _ListenLocationState extends State<ListenLocation> {
  final Location location = Location();

  LocationData? _location;
  StreamSubscription<LocationData>? _locationSubscription;
  String? _error;

  Future<void> _listenLocation() async {
    location.changeSettings(interval: 500);
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

        _location = currentLocation;
      });
    });
    setState(() {});
  }

  Future<void> _stopListen() async {
    await _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listen location: ${_error ?? '${_location ?? "unknown"}'}',
        ),
        Text(
          DateTime.now().toIso8601String(),
          style: const TextStyle(fontSize: 20),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 42),
              child: ElevatedButton(
                onPressed:
                    _locationSubscription == null ? _listenLocation : null,
                child: const Text('Listen'),
              ),
            ),
            ElevatedButton(
              onPressed: _locationSubscription != null ? _stopListen : null,
              child: const Text('Stop'),
            ),
          ],
        ),
      ],
    );
  }
}
```
