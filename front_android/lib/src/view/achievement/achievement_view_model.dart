import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/repository/achievement_repository.dart';

final achievementProvider =
    ChangeNotifierProvider((ref) => AchievementViewModel());

final class AchievementViewModel with ChangeNotifier {
  var achievementRepository = AchievementRepository();

  List<Achievement> get achievementList =>
      achievementRepository.achievementList;
  int get achievementCount => achievementRepository.achievementList.length;

  // 업적 리스트 가져오기
  void fetchAchievementList() async {
    await achievementRepository.getAchievementList();
    notifyListeners();
  }
}
