```
import 'package:location/location.dart';

interface class LocationPermission {
  static final Location _location = Location();

  static Future<bool> checkPermission() async {
    final permissionGrantedResult = await _location.hasPermission();
    return (permissionGrantedResult == PermissionStatus.granted) ||
        (permissionGrantedResult == PermissionStatus.grantedLimited);
  }

  static Future<bool> requestPermission() async {
    final permissionGrantedResult = await _location.requestPermission();
    return (permissionGrantedResult == PermissionStatus.granted) ||
        (permissionGrantedResult == PermissionStatus.grantedLimited);
  }

  static Future<bool> requestLocationService() async {
    if (await _location.serviceEnabled()) {
      return true;
    }

    final serviceRequestedResult = await _location.requestService();
    return serviceRequestedResult;
  }
}
```
