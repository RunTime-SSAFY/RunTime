import 'package:flutter/foundation.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/service/https_request_service.dart';

class AchievementRepository {
  List<Achievement> achievementList = [];
  var api = apiInstance;

  Future<void> getAchievementList() async {
    try {
      var response = await api.get('/api/achievements');
      print("--------[AchievementRepository]--------");
      print(response.data);
      achievementList = (response.data as List)
          .map((achievement) => Achievement.fromJson(achievement))
          .toList();
    } catch (e, s) {
      debugPrint('$e, $s');
      throw Error();
    }
  }
}
