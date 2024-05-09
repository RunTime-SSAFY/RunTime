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

  factory MatchingRoomData.fromJson(Map<String, dynamic> json) {
    return MatchingRoomData(
      matchingRoomId: json['matchingRoomId'],
      opponentId: json['opponentId'],
    );
  }
}

class Participant {
  final int memberId;
  final String nickname, characterImgUrl;
  final bool isManager, isReady;

  Participant({
    required this.memberId,
    required this.nickname,
    required this.characterImgUrl,
    required this.isManager,
    required this.isReady,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        memberId: json['memberId'],
        nickname: json['nickname'],
        characterImgUrl: json['characterImgUrl'],
        isManager: json['isManager'] ?? false,
        isReady: json['isReady'] ?? false,
      );
}

class BattleRecordOfParticipant {
  final String nickname;
  final String characterImgUrl;

  BattleRecordOfParticipant({
    required this.nickname,
    required this.characterImgUrl,
  });

  double distance = 0;
}
