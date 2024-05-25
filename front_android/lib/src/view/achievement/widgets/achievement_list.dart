import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/achievement/widgets/achievement_list_item.dart';

// DISTANCE인 경우 km 출력하기 위한 함수
String getUnit(String criteria) {
  switch (criteria) {
    case "DISTANCE":
      return 'km';
    case "DURATION":
      return '분';
    case "SPEED":
      return 'km/h';
    case "CALORIE":
      return 'kcal';
    case "COUNT_FRIENDS":
      return '회';
    default:
      return '';
  }
}

class AchievementList extends ConsumerWidget {
  const AchievementList({
    required this.confettiController,
    required this.achievementList,
    required this.achievementCount,
    super.key,
  });

  final List<Achievement> achievementList;
  final int achievementCount;

  final ConfettiController? confettiController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<List<Color>> cardColors = [
      [
        ref.color.list1Main,
        ref.color.list1Sub,
        ref.palette.purple300
      ], // purple
      [ref.color.list2Main, ref.color.list2Sub, ref.palette.blue300], // blue
      [ref.color.list3Main, ref.color.list3Sub, ref.palette.green300], // green
      [ref.color.list4Main, ref.color.list4Sub, ref.palette.pink300], // pink
      [ref.color.list5Main, ref.color.list5Sub, ref.palette.red300], // red
    ];

    return ListView.builder(
      itemCount: achievementCount,
      itemBuilder: (context, index) {
        final cardColorsIndex = index == 0 ? 0 : index % cardColors.length;
        final achievement = achievementList[index];

        return AchievementListItem(
          id: achievement.id ?? 0,
          type: achievement.type ?? 0,
          name: achievement.name ?? '지금까지 얼마나 달렸나요?',
          detail: achievement.detail ?? '총 달린 거리',
          criteria: getUnit(achievement.criteria ?? "DISTANCE"),
          grade: achievement.grade ?? 1,
          goal: achievement.goal ?? 1,
          prevGoal: achievement.prevGoal ?? 0,
          progress: achievement.progress ?? 1,
          characterName: achievement.characterName ?? '',
          characterImgUrl:
              achievement.characterImgUrl ?? 'assets/images/mainCharacter.png',
          isFinal: achievement.isFinal ?? false,
          isComplete: achievement.isComplete ?? true,
          isReceive: achievement.isReceive ?? false,
          cardBackgroundGradient1: cardColors[cardColorsIndex][0],
          cardBackgroundGradient2: cardColors[cardColorsIndex][1],
          cardTextColor: cardColors[cardColorsIndex][2],
          confettiController: confettiController,
        );
      },
    );
  }
}
