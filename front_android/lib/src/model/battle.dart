import 'package:front_android/src/service/user_service.dart';
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
        'lng': position.longitude,
        'lat': position.latitude,
        'currentDistance': currentDistance,
        'idx': index,
        'nickname': UserService.instance.nickname,
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
  final int memberId;
  final String nickname, characterImgUrl;
  final bool isManager, isReady;
  double distance = 0;
  DateTime lastDateTime;

  Participant({
    required this.memberId,
    required this.nickname,
    required this.characterImgUrl,
    required this.isManager,
    required this.isReady,
  }) : lastDateTime = DateTime.now();

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        memberId: json['memberId'] ?? -1,
        nickname: json['nickname'] ?? '',
        characterImgUrl: json['characterImgUrl'] ?? '',
        isManager: json['isManager'] ?? false,
        isReady: json['isReady'] ?? false,
      );
}
