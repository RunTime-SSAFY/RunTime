import 'package:location/location.dart';

interface class LocationPermissionService {
  static final Location _location = Location();

  static Future<bool> _checkPermission() async {
    final permissionGrantedResult = await _location.hasPermission();
    return (permissionGrantedResult == PermissionStatus.granted);
  }

  static Future<bool> _requestPermission() async {
    final permissionGrantedResult = await _location.requestPermission();
    return (permissionGrantedResult == PermissionStatus.granted);
  }

  static Future<bool> _requestLocationService() async {
    final serviceRequestedResult = await _location.requestService();
    return serviceRequestedResult;
  }

  static Future<bool> getPermission() async {
    bool permissionGranted = await _checkPermission();

    bool serviceRequested = await _requestLocationService();
    if (!serviceRequested) {
      return false;
    }

    if (!permissionGranted) {
      permissionGranted = await _requestPermission();
      if (!permissionGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
