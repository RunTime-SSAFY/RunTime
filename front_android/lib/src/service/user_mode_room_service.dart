import 'package:flutter/material.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserModeRoomService {
  var api = apiInstance;

  Future<void> makeRoom({required MakeRoomModel makeRoomModel}) async {
    try {
      await api.post('/api/rooms', data: makeRoomModel.toJson());
    } catch (error, stackTrace) {
      debugPrint('$error, $stackTrace');
    }
  }
}
