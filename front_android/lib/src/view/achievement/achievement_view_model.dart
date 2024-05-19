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
  Achievement get newAchievement => achievementRepository.newAchievement;

  // 업적 리스트 가져오기
  void fetchAchievementList() async {
    updateAchievement();
    await achievementRepository.getAchievementList();
    notifyListeners();
  }

  // 업적 보상 받기
  void getReward(int typeId) async {
    print('viewModel - typeId : $typeId');
    await achievementRepository.getReward(typeId);
    notifyListeners();
  }

  void updateAchievement() async {
    await achievementRepository.updateAchievement();
    notifyListeners();
  }

  // 초기화
  void clearAchievementList() {
    achievementRepository.clearAchievementList();
    notifyListeners();
  }
}
