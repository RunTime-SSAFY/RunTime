import 'package:flutter/material.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserModeRoomService {
  var api = apiInstance;

  Future<UserModeRoom> makeRoom({required MakeRoomModel makeRoomModel}) async {
    try {
      var response = await api.post('/api/rooms', data: makeRoomModel.toJson());

      return UserModeRoom.fromJson(response.data);
    } catch (error, stackTrace) {
      debugPrint('$error, $stackTrace');
      throw Error();
    }
  }
}
