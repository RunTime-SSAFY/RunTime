import 'package:flutter/material.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserService {
  UserService._() {
    init();
  }

  void init() async {
    try {
      var response = await apiInstance.get('api/members');

      var data = response.data;
      nickname = data['nickname'] ?? '';
      characterImgUrl = data['characterImgUrl'] ?? '';
      weight = data['weight'] ?? '';
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static final _instance = UserService._();
  static UserService get instance => _instance;

  String nickname = '';
  String email = '';
  String characterImgUrl = '';
  double weight = 65;

  Future<bool> changeUserInfor({
    required String nickname,
    required double weight,
  }) async {
    try {
      await apiInstance.patch('api/members', data: {
        "nickname": nickname,
        "weight": weight,
      });
      return true;
    } catch (error) {
      return false;
    }
  }
}
