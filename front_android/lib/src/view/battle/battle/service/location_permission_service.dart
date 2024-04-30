import 'package:geolocator/geolocator.dart';

interface class LocationPermissionService {
  static Future<bool> getPermission() async {
    bool isServiceOn = await Geolocator.isLocationServiceEnabled();

    if (!isServiceOn) {
      isServiceOn = await Geolocator.openLocationSettings();
      if (!isServiceOn) {
        return false;
      }
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
      return true;
    }

    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }
}
