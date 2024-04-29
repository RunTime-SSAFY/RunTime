flutter pub의 location 패키지 코드

```
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/location/get_location.dart';
import 'package:flutter_application_1/src/location/permission_status.dart';

class LocationMain extends StatefulWidget {
  const LocationMain({super.key});

  @override
  State<LocationMain> createState() => _LocationMainState();
}

class _LocationMainState extends State<LocationMain> {
  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool permissionGranted = await LocationPermission.checkPermission();
    if (!permissionGranted) {
      permissionGranted = await LocationPermission.requestPermission();
      if (!permissionGranted) {
        return;
      }
      return;
    }

    bool serviceRequested = await LocationPermission.requestLocationService();
    if (!serviceRequested) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const GetLocation();
  }
}
```
