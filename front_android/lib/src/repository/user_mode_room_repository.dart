import 'package:flutter/material.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserModeRoomRepository {
  UserModeRoomRepository();

  bool hasNext = true;
  int? lastId;

  String roomTitle = '';
  double distance = 3;

  Future<List<UserModeRoom>> getUserModeRoomList(
      {String? searchWord, bool? isSecret}) async {
    if (!hasNext) return [];
    try {
      final response = await apiInstance.get(
        '/api/rooms',
        queryParameters: {
          if (lastId != null) 'lastId': lastId,
          if (searchWord != null && searchWord != '') 'searchWord': searchWord,
          'isSecret': isSecret ?? false,
          'pageSize': 5,
        },
      );

      hasNext = response.data['hasNext'];
      lastId = response.data['lastId'];

      return response.data['data']
          .map<UserModeRoom>((data) => UserModeRoom.fromJson(data))
          .toList();
    } catch (error, stackTrace) {
      debugPrint('$error, $stackTrace');
      return [];
    }
  }

  Future<Map<String, dynamic>> enterRoom(
    int roomId,
    String? password,
  ) async {
    try {
      final response = await apiInstance.post(
        'api/rooms/$roomId/enter',
        data: {
          'data': password,
        },
      );

      return response.data;
    } catch (error) {
      debugPrint(error.toString());
      throw Error();
    }
  }

  Future<void> roomOut(int roomId) async {
    await apiInstance.delete('api/rooms/$roomId/exit');
  }

  void setRoomInfo(UserModeRoom room) {
    roomTitle = room.name;
    distance = room.distance;
  }
}
