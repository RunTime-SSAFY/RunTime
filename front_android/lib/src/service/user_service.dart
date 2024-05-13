import 'package:flutter/material.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserService {
  UserService._();

  static final _instance = UserService._();
  static UserService get instance => _instance;

  late String nickname;
  late String email;
  late String characterImgUrl;
  late int characterId;
  double weight = 65;
  late int tierScore;
  late String tierName = 'beginner_1';

  Future<bool> changeUserInfor({
    required String newNickname,
    required double newWeight,
  }) async {
    try {
      await apiInstance.patch('api/members', data: {
        "nickname": newNickname,
        "weight": newWeight,
      });
      nickname = newNickname;
      weight = newWeight;
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<void> getUserInfor() async {
    try {
      var response = await apiInstance.get('api/members');
      print(response);
      var data = response.data;
      nickname = data['nickname'];
      weight = data['weight'];
      characterId = data['characterId'];
      characterImgUrl = data['characterImgUrl'] ?? '';
      tierScore = data['tierScore'];
      tierName = data['tierName'];
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
