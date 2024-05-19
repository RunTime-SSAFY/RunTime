import 'package:flutter/foundation.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/service/https_request_service.dart';

class AchievementRepository {
  List<Achievement> achievementList = [];
  Achievement newAchievement = Achievement();
  var api = apiInstance;

  Future<void> getAchievementList() async {
    try {
      var response = await api.get('/api/achievements');
      print("--------[AchievementRepository] getAchievementList --------");
      print(response.data);
      achievementList = (response.data as List)
          .map((achievement) => Achievement.fromJson(achievement))
          .toList();
    } catch (e, s) {
      debugPrint('$e, $s');
      throw Error();
    }
  }

  // 보상받기 함수
  Future<void> getReward(int typeId) async {
    try {
      var response =
          await api.patch('/api/achievements/$typeId'); // Use RequestOptions
      newAchievement = Achievement.fromJson(response.data);
      print("--------[AchievementRepository] getReward --------");
      print(response.data);
    } catch (e, s) {
      debugPrint('$e, $s');
      throw Error();
    }
  }

  Future<void> updateAchievement() async {
    try {
      var response = await api.patch('/api/achievements');
      print("--------[AchievementRepository] updateAchievement --------");
      print(response.data);
    } catch (e, s) {
      debugPrint('$e, $s');
      throw Error();
    }
  }

  // 초기화
  void clearAchievementList() {
    achievementList = [];
  }
}
