import 'package:flutter/material.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserModeRoomRepository {
  UserModeRoomRepository();

  final api = apiInstance;

  bool hasNext = true;
  int lastId = 0;

  Future<List<UserModeRoom>> getUserModeRoomList(
      {int? lastId, String? searchWord, bool? isSecret}) async {
    if (!hasNext) return [];
    try {
      final response = await api.get(
        '/api/rooms',
        queryParameters: {
          if (lastId != null) 'lastId': lastId,
          if (searchWord != null) 'searchWord': searchWord,
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

  Future<List<UserModeRoom>> getMoreRoomList() {
    return getUserModeRoomList(lastId: lastId);
  }
}
