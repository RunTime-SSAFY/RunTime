enum UserModeRoomStatus {
  // ignore: constant_identifier_names
  WAITING,
  // ignore: constant_identifier_names
  IN_PROGRESS;
}

class UserModeRoom {
  // 방의 Id
  final int roomId;
  // 방의 제목
  final String name;
  // 정원
  final int capacity;
  // 목표 거리
  final double distance;
  // 방의 상태 대기 중: WAITING, 게임 진행 중: IN_PROGRESS
  final UserModeRoomStatus status;
  // 현재 방의 정원
  final int headcount;

  UserModeRoom({
    required this.roomId,
    required this.name,
    required this.capacity,
    required this.distance,
    required this.status,
    required this.headcount,
  });

  factory UserModeRoom.fromJson(Map<String, dynamic> json) {
    return UserModeRoom(
      roomId: json['roomId'] ?? 0,
      name: json['name'] ?? '',
      capacity: json['capacity'] ?? 0,
      distance: json['distance'] ?? 0,
      status: json['status'] ?? UserModeRoomStatus.IN_PROGRESS,
      headcount: json['headcount'] ?? 1,
    );
  }
}
