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

  Map<String, dynamic> toJson() => {
        'position': {
          'lng': position.longitude,
          'lat': position.latitude,
        },
        'currentDistance': currentDistance,
        'index': index,
      };
}

class MatchingRoomData {
  MatchingRoomData({
    required this.matchingRoomId,
    required this.opponentId,
  });
  final int matchingRoomId;
  final int opponentId;

  factory MatchingRoomData.fromJson(Map<String, dynamic> json) =>
      MatchingRoomData(
        matchingRoomId: json['matchingRoomId'],
        opponentId: json['opponentId'],
      );
}
