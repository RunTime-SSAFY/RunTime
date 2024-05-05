import 'package:geolocator/geolocator.dart';

class BattleSocketData {
  final Position position;
  final double currentDistance;
  final int index;

  const BattleSocketData({
    required this.position,
    required this.currentDistance,
    required this.index,
  });
}
