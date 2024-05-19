import 'package:front_android/src/service/user_service.dart';
import 'package:geolocator/geolocator.dart';

class BattleSocketData {
  final Position position;
  final double currentDistance;
  final int index;
  final int roomId;
  final bool reenter;

  const BattleSocketData({
    required this.position,
    required this.currentDistance,
    required this.index,
    required this.roomId,
    required this.reenter,
  });

  Map<String, dynamic> toJson() => {
        'lng': position.longitude,
        'lat': position.latitude,
        'distance': currentDistance,
        'idx': index,
        'nickname': UserService.instance.nickname,
        'roomId': roomId,
        'reenter': reenter,
      };
}

class MatchingRoomData {
  MatchingRoomData({
    required this.matchingRoomId,
    required this.memberId,
    required this.uuid,
  });
  final int matchingRoomId;
  final int memberId;
  final String uuid;

  factory MatchingRoomData.fromJson(Map<String, dynamic> json) {
    return MatchingRoomData(
      matchingRoomId: json['matchingRoomId'],
      memberId: json['memberId'],
      uuid: json['uuid'],
    );
  }
}

class Participant {
  final String nickname, characterImgUrl;
  final bool isManager, isReady;
  double distance = 0;
  DateTime lastDateTime;

  Participant({
    required this.nickname,
    required this.characterImgUrl,
    required this.isManager,
    required this.isReady,
    required this.distance,
    required this.lastDateTime,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        nickname: json['nickname'] ?? '',
        characterImgUrl: json['characterImgUrl'] ?? '',
        isManager: json['manager'] ?? false,
        isReady: json['ready'] ?? false,
        distance: json['distance'] ?? 0,
        lastDateTime: json['lastDateTime'] ?? DateTime.now(),
      );
}
