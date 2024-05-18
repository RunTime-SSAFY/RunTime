import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/achievement/achievement_view_model.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:go_router/go_router.dart';

class AchievementRewardView extends ConsumerStatefulWidget {
  const AchievementRewardView({
    required this.data,
    super.key,
  });

  final AchievementRewardRequest data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AchievementRewardViewState();
}

class _AchievementRewardViewState extends ConsumerState<AchievementRewardView> {
  late AchievementViewModel viewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getReward(widget.data.typeId);
      print(viewModel.achievementList);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(achievementProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 도전과제 완료!
                Text(
                  '도전과제 완료!',
                  style: ref.typo.mainTitle.copyWith(fontSize: 42),
                ),
                // LV.2 로 레벨업

                // 이미 최종 레벨이면 MAX로 표시
                widget.data.isFinal
                    ? Text(
                        '이미 최고 레벨입니다!',
                        style: ref.typo.headline1
                            .copyWith(color: ref.palette.gray600),
                      )
                    : Row(
                        children: [
                          Text(
                            widget.data.isFinal
                                ? 'MAX'
                                : 'LV.${viewModel.newAchievement.grade.toString()}',
                            style: ref.typo.headline1
                                .copyWith(color: ref.color.accept),
                          ),
                          Text(
                            ' 로 레벨업!',
                            style: ref.typo.headline1
                                .copyWith(color: ref.palette.gray600),
                          ),
                        ],
                      )
              ],
            ),

            // 캐릭터 이미지(가운데 정렬)
            Center(
              child: Column(
                children: [
                  // '캐릭터 잠금 해제' 텍스트
                  Text(
                    '캐릭터 잠금 해제',
                    style:
                        ref.typo.subTitle2.copyWith(color: ref.palette.gray600),
                  ),
                  // 캐릭터 이미지
                  Image.network(
                    widget.data.characterImgUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  // 캐릭터 이름
                  Text(
                    widget.data.characterName,
                    style: ref.typo.headline1
                        .copyWith(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  // 아래 공간 만들기
                  const SizedBox(height: 50),
                ],
              ),
            ),

            // 확인 버튼
            Button(
              onPressed: () {
                viewModel.fetchAchievementList();
                context.pop();
              },
              text: '확인',
              backGroundColor: ref.color.accept,
              fontColor: ref.color.onAccept,
            )
          ],
        ),
      ),
    );
  }
}
