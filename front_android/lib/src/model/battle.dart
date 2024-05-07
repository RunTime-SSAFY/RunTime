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

class MatchingData {
  MatchingData({
    required this.matchingRoomId,
    required this.opponentId,
  });
  final int matchingRoomId;
  final int opponentId;

  factory MatchingData.fromJson(Map<String, dynamic> json) => MatchingData(
        matchingRoomId: json['matchingRoomId'],
        opponentId: json['opponentId'],
      );
}
