import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/achievement/widgets/achievement_list_item.dart';

class AchievementList extends ConsumerWidget {
  const AchievementList({
    required this.achievementList,
    required this.achievementCount,
    super.key,
  });

  final List<Achievement> achievementList;
  final int achievementCount;

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
          name: achievement.name ?? '',
          detail: achievement.detail ?? '',
          criteria: achievement.criteria ?? '',
          grade: achievement.grade ?? 0,
          goal: achievement.goal ?? 0,
          progress: achievement.progress ?? 0,
          characterName: achievement.characterName ?? '',
          characterImgUrl: achievement.characterImgUrl ?? '',
          isFinal: achievement.isFinal ?? false,
          isComplete: achievement.isComplete ?? false,
          isReceive: achievement.isReceive ?? false,
          cardBackgroundGradient1: cardColors[cardColorsIndex][0],
          cardBackgroundGradient2: cardColors[cardColorsIndex][1],
          cardTextColor: cardColors[cardColorsIndex][2],
        );
      },
    );

    // return ListView(
    //   // 아이템 10개 생성
    //   children: List.generate(5, (index) {
    //     // colors 배열을 순환하면서 컬러를 보내준다.
    //     final cardColorsIndex = index == 0 ? 0 : index % cardColors.length;
    //     return AchievementListItem(
    //       id: index + 1,
    //       typeId: index + 1,
    //       name: '지금까지 얼마나 달렸나요?',
    //       detail: '총 달린 거리',
    //       criteria: "km",
    //       grade: 1,
    //       goal: index == 1 ? 3.0 : 2.0 * (index + 1),
    //       current: index == 1
    //           ? 3.0
    //           : (Random().nextDouble() + 1.0) *
    //               (index + 1), // 0이면 0.01로 만들어주는 로직 필요함 (0이면 에러남)
    //       characterName: '기르핀',
    //       characterImgUrl: 'assets/images/mainCharacter.png',
    //       isFinal: false,
    //       isComplete: index == 1 ? true : false,
    //       isReceived: false,
    //       cardBackgroundGradient1: cardColors[cardColorsIndex][0],
    //       cardBackgroundGradient2: cardColors[cardColorsIndex][1],
    //       cardTextColor: cardColors[cardColorsIndex][2],
    //     );
    //   }),
    // );
  }
}
