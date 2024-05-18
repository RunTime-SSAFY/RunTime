interface class UserModeRoomStatusHelper {
  static const waiting = 'WAITING';
  static const inProgress = 'IN_PROGRESS';
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
  final String status;
  // 현재 방의 정원
  final int headcount;
  //
  final bool isSecret;
  final String uuid;

  UserModeRoom({
    required this.roomId,
    required this.name,
    required this.capacity,
    required this.distance,
    required this.status,
    required this.headcount,
    required this.isSecret,
    required this.uuid,
  });

  factory UserModeRoom.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModeRoom(
      roomId: json['roomId'] ?? 0,
      name: json['name'] ?? '',
      capacity: json['capacity'] ?? 0,
      distance: json['distance'].toDouble() ?? 0,
      status: json['status'] ?? UserModeRoomStatusHelper.inProgress,
      headcount: json['headcount'] ?? 1,
      isSecret: json['isSecret'] ?? false,
      uuid: json['uuid'] ?? '',
    );
  }
}

class MakeRoomModel {
  String _name; // 방 이름
  String get name => _name;
  set name(String value) {
    if (value.length < 20) _name = value;
  }

  double _distance; // 목표 거리
  double get distance => _distance;
  set distance(double value) {
    switch (value) {
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        _distance = value;
        break;
    }
  }

  int _capacity; // 정원
  int get capacity => _capacity;

  set capacity(int value) {
    if (value <= 5) _capacity = value;
  }

  String? _password;
  String? get password => _password;

  set password(String? value) {
    if (value == null) {
      _password = null;
      return;
    }
    if (value.length < 20) {
      _password = value;
    } else if (value.isEmpty) {
      _password = null;
    }
  }

  MakeRoomModel({
    String name = '',
    double distance = 3,
    int capacity = 4,
    String? password,
  })  : _password = password,
        _capacity = capacity,
        _distance = distance,
        _name = name;

  Map<String, dynamic> toJson() => {
        'name': name,
        'distance': distance,
        'capacity': capacity,
        'password': password,
      };
}
