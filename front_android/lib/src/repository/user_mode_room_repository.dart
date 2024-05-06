import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserModeRoomRepository {
  UserModeRoomRepository();

  final api = apiInstance;

  Future<List<UserModeRoom>> getUserModeRoomList(
      {int? lastId, String? searchWord, bool? isSecret}) async {
    try {
      final response = await api.get(
        '/api/rooms',
        queryParameters: {
          if (lastId != null) 'lastId': lastId,
          if (searchWord != null) 'searchWord': searchWord,
          if (isSecret != null) 'isSecret': isSecret,
        },
      );
      return jsonDecode(response.data)
          .map<UserModeRoom>((json) => UserModeRoom.fromJson(json));
    } catch (error, stackTrace) {
      debugPrint('$error, $stackTrace');
      return a.map((e) => UserModeRoom.fromJson(e)).toList();
    }
  }
}

// 주석: 임시 데이터
var a = [
  {
    "roomId": 1,
    "name": '안녕',
    "capacity": 4,
    "distance": 1,
    "status": UserModeRoomStatus.WAITING,
    "headcount": 1
  },
  {
    "roomId": 2,
    "name": '안녕 반가워',
    "capacity": 2,
    "distance": 3,
    "status": UserModeRoomStatus.WAITING,
    "headcount": 2
  },
  {
    "roomId": 4,
    "name": '달리기',
    "capacity": 4,
    "distance": 5,
    "status": UserModeRoomStatus.WAITING,
    "headcount": 3
  },
  {
    "roomId": 4,
    "name": '하하하ㅏ하하',
    "capacity": 3,
    "distance": 3,
    "status": UserModeRoomStatus.WAITING,
    "headcount": 2
  },
  {
    "roomId": 5,
    "name": 'english name',
    "capacity": 2,
    "distance": 5,
    "status": UserModeRoomStatus.IN_PROGRESS,
    "headcount": 2
  },
];
