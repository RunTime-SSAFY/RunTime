import 'package:flutter/material.dart';
import 'package:front_android/src/service/https_request_service.dart';

class UserService {
  UserService._();

  static final _instance = UserService._();
  static UserService get instance => _instance;

  String nickname = 'temp';
  String characterImgUrl = '';
  int characterId = 1;
  double weight = 65;
  int tierScore = 0;
  String tierName = 'beginner_3';

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
      var data = response.data;
      nickname = data['nickname'] ?? '';
      weight = data['weight'] ?? weight;
      characterId = data['characterId'] ?? 1;
      characterImgUrl = data['characterImgUrl'] ?? '';
      tierScore = data['tierScore'] ?? 0;
      tierName = data['tierName'] ?? tierName;
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
