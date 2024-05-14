import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserModeRoomRepository {
  UserModeRoomRepository();

  bool hasNext = true;
  int? lastId;

  String roomTitle = '';
  double distance = 3;

  Future<List<UserModeRoom>> getUserModeRoomList(
      {int? lastId, String? searchWord, bool? isSecret}) async {
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

  Future<List<Participant>> fetchingParticipants(int roomId) async {
    try {
      final room = await apiInstance.post('api/rooms/$roomId/enter');
      final data = jsonDecode(room.data);
      print(data);
      return data['data'].map((element) => Participant.fromJson(element));
    } catch (error) {
      debugPrint(error.toString());
      throw Error();
    }
  }

  Future<List<UserModeRoom>> getMoreRoomList() {
    return getUserModeRoomList(lastId: lastId);
  }
}
