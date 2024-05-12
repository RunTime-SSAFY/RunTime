import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/achievement/widgets/achievement_animated_progress_bar.dart';

class AchievementListItem extends ConsumerWidget {
  const AchievementListItem({
    required this.id,
    required this.typeId,
    required this.name,
    required this.detail,
    required this.criteria,
    required this.grade,
    required this.goal,
    required this.current,
    required this.characterName,
    required this.characterImgUrl,
    required this.isFinal,
    required this.isComplete,
    required this.isReceived,
    required this.cardBackgroundGradient1,
    required this.cardBackgroundGradient2,
    required this.cardTextColor,
    super.key,
  });

  final int id; // 이건 없어도 되지 않을까요?
  final int typeId; // 도전과제 분류 id
  final String name; // 도전과제 이름
  final String detail; // 도전과제 상세 내용
  final String criteria; // 수치의 단위
  final int grade; // 도전과제 단계
  final double goal; // 도전과제가 완료되는 기준
  final double current; // 진행도
  final String characterName; // 보상으로 받는 캐릭터 이름
  final String characterImgUrl; // 보상으로 받는 캐릭터 이미지
  final bool isFinal; // 마지막 단계인지
  final bool isComplete; // 완료했는지
  final bool isReceived; // 수령했는지

  // !isComplete && !isReceived && !isFinal 인 경우에만 보상받기 표시
  bool get isShowRewardButton => isComplete && !isReceived;

  // 색상
  final Color cardBackgroundGradient1;
  final Color cardBackgroundGradient2;
  final Color cardTextColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      // 실제 보이는 카드 모양 시작
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  cardBackgroundGradient1,
                  cardBackgroundGradient2,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // 제목
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      style: ref.typo.headline2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // 캐릭터
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // 캐릭터 이미지
                        Image.asset(
                          characterImgUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),

                        // 캐릭터 이름
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '성공시 ',
                              style: ref.typo.subTitle4
                                  .copyWith(color: cardTextColor),
                            ),
                            Text(
                              characterName,
                              style: ref.typo.subTitle4
                                  .copyWith(color: ref.palette.yellow400),
                            ),
                            Text(
                              ' 획득',
                              style: ref.typo.subTitle4
                                  .copyWith(color: cardTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // isComplete이 true이고, isReceive가 false이고, isFinal이 false 인 경우 위젯 숨기기
                  // 조건에 따라 위젯을 투명하게 만들기

                  // 부제목 및 과제 달성 수치
                  Opacity(
                    opacity: !isShowRewardButton ? 1.0 : 0.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 부제목
                        Text(
                          detail, // 도전과제 상세 내용
                          style: ref.typo.subTitle4.copyWith(
                            color: cardTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // 과제 달성 수치
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // 현재 수치
                            Text(
                              // 소수점 첫째 자리까지 표시
                              current.toStringAsFixed(1).toString(),
                              style: ref.typo.subTitle3
                                  .copyWith(color: ref.palette.yellow400),
                            ),
                            // 목표 수치
                            Text(
                              ' / ' +
                                  //소수점 첫째자리가 0이라면 소수점을 표시하지 않음
                                  '${goal.toStringAsFixed(1).split('.')[1] == '0' ? goal.toStringAsFixed(0) : goal.toStringAsFixed(1)}' +
                                  criteria,
                              style: ref.typo.subTitle4
                                  .copyWith(color: ref.palette.yellow400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 단계 및 수치 그래프
                  Opacity(
                    opacity: !isShowRewardButton ? 1.0 : 0.0,
                    child: Row(
                      children: [
                        // 단계
                        Text(
                          'LV.$grade',
                          style: ref.typo.subTitle3.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // 가로 막대형 수치 그래프(0부터 현재 수치까지 증가하는 애니메이션 포함)
                        AchievementAnimatedProgressBar(
                            current: current, goal: goal)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stack 위젯 크기 만큼 버튼을 덮어씌워서 버튼을 누르면 도전과제 완료 표시
          if (isShowRewardButton)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            ref.color.achievementRewardButtonGradient1,
                            ref.color.achievementRewardButtonGradient2,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '보상받기',
                          style: ref.typo.subTitle3.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ),
            ),
        ], // Stack children
      ),
    );
  }
}
