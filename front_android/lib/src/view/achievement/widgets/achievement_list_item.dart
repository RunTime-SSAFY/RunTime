import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/achievement.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/achievement/widgets/achievement_animated_progress_bar.dart';
import 'package:front_android/util/helper/number_format_helper.dart';
import 'package:go_router/go_router.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';

class AchievementListItem extends ConsumerWidget {
  const AchievementListItem({
    required this.id,
    required this.type,
    required this.name,
    required this.detail,
    required this.criteria,
    required this.grade,
    required this.goal,
    required this.prevGoal,
    required this.progress,
    required this.characterName,
    required this.characterImgUrl,
    required this.isFinal,
    required this.isComplete,
    required this.isReceive,
    required this.cardBackgroundGradient1,
    required this.cardBackgroundGradient2,
    required this.cardTextColor,
    required this.confettiController,
    super.key,
  });

  final int id;
  final int type;
  final String name;
  final String detail;
  final String criteria;
  final int grade;
  final double goal;
  final double prevGoal;
  final double progress;
  final String characterName;
  final String characterImgUrl;
  final bool isFinal;
  final bool isComplete;
  final bool isReceive;

  // !isComplete && !isReceived && !isFinal 인 경우에만 보상받기 표시

  // 색상
  final Color cardBackgroundGradient1;
  final Color cardBackgroundGradient2;
  final Color cardTextColor;

  bool get isShowRewardButton => isComplete && !isReceive;

  final ConfettiController? confettiController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    confettiController?.play();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      // 실제 보이는 카드 모양 시작
      child: Stack(
        children: [
          Positioned(
            child: Container(
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
                    Row(
                      children: [
                        // 제목
                        SizedBox(
                          // 화면 전체 너비 - 페이지 좌우 패딩값 - 카드 좌우 패딩값 - 레벨 박스 아이콘의 크기
                          width:
                              MediaQuery.of(context).size.width - 40 - 40 - 46,
                          // 텍스트가 오버플로우 되면 애니메이션으로 스크롤되도록 함
                          child: OverflowTextAnimated(
                            // text: isFinal ? 'MAX' : 'LV.$grade',
                            text: name,
                            style: ref.typo.headline2.copyWith(
                              color: ref.color.white,
                            ),
                            curve: Curves.fastEaseInToSlowEaseOut,
                            animation: OverFlowTextAnimations.scrollOpposite,
                            animateDuration: const Duration(milliseconds: 1500),
                            delay: const Duration(milliseconds: 500),
                          ),
                        ),

                        // Text(
                        //   name,
                        //   style: ref.typo.headline2.copyWith(
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // 레벨 박스 아이콘
                        Container(
                          width: 46,
                          decoration: BoxDecoration(
                            color: cardTextColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 1, bottom: 1),
                            child: Center(
                              child: Text(
                                isFinal ? 'MAX' : 'LV.$grade',
                                style: ref.typo.subTitle3.copyWith(
                                  color: ref.color.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    // 부제목
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        detail, // 도전과제 상세 내용
                        style: ref.typo.subTitle4.copyWith(
                          color: cardTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // 캐릭터
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: isComplete && isReceive
                          ? Column(
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Center(
                                    child: Icon(
                                      Icons.auto_awesome,
                                      color: ref.palette.yellow400,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                Text(
                                  '모든 보상을 수령했습니다',
                                  style: ref.typo.subTitle4
                                      .copyWith(color: cardTextColor),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                // 캐릭터 이미지 (온라인 사진 가져와서 이미지 자르기(x: 460, y: 40, w: 1000, x: 1000))

                                Image.network(
                                  characterImgUrl,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),

                                const SizedBox(height: 20),

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
                                      style: ref.typo.subTitle4.copyWith(
                                          color: ref.palette.yellow400),
                                    ),
                                    Text(
                                      ' 획득',
                                      style: ref.typo.subTitle4
                                          .copyWith(color: cardTextColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                    ),

                    // isComplete이 true이고, isReceive가 false이고, isFinal이 false 인 경우 위젯 숨기기
                    // 조건에 따라 위젯을 투명하게 만들기

                    // 과제 달성 수치
                    Opacity(
                      opacity: !isShowRewardButton ? 1.0 : 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 이전 목표수치
                          Text(
                            NumberFormatHelper.floatTrunk(prevGoal),
                            // '${prevGoal.toStringAsFixed(1).split('.')[1] == '0' ? prevGoal.toStringAsFixed(0) : prevGoal.toStringAsFixed(1)}',
                            style: ref.typo.subTitle4
                                .copyWith(color: cardTextColor),
                          ),

                          // 현재 수치와 목표 수치
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // 현재 수치
                              Text(
                                // 소수점 첫째 자리까지 표시
                                NumberFormatHelper.floatTrunk(progress),
                                style: ref.typo.subTitle3
                                    .copyWith(color: ref.palette.yellow400),
                              ),
                              // 목표 수치
                              Text(
                                //소수점 첫째자리가 0이라면 소수점을 표시하지 않음
                                ' / ${NumberFormatHelper.floatTrunk(goal)}$criteria',
                                style: ref.typo.subTitle4
                                    .copyWith(color: ref.palette.yellow400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 수치 그래프
                    Opacity(
                      opacity: !isShowRewardButton ? 1.0 : 0.0,
                      child:
                          // 가로 막대형 수치 그래프(0부터 현재 수치까지 증가하는 애니메이션 포함)
                          AchievementAnimatedProgressBar(
                        current: progress,
                        goal: goal,
                        prevGoal: prevGoal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Stack 위젯 크기 만큼 버튼을 덮어씌워서 버튼을 누르면 도전과제 완료 표시
          if (isShowRewardButton)
            Positioned.fill(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // viewModel.fetchAchievementList();
                        // print(
                        //     'id : ${id}, typeId: ${type}, isFinal : $isFinal, characterName : $characterName, characterImgUrl : $characterImgUrl');
                        AchievementRewardRequest request =
                            AchievementRewardRequest(
                          id: id,
                          typeId: type,
                          isFinal: isFinal,
                          characterName: characterName,
                          characterImgUrl: characterImgUrl,
                        );
                        debugPrint(
                            '----------AchievementRewardRequest request -------');
                        debugPrint(request.toString());
                        context.push('/achievement/reward', extra: request);
                      },
                      child: Container(
                        // width: double.infinity,
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
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                '보상받기',
                                style: ref.typo.subTitle3.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if(confettiController != null)
                              Align(
                                child: ConfettiWidget(
                                  confettiController: confettiController!,
                                  shouldLoop: true,
                                  blastDirection: 3.14,
                                  blastDirectionality:
                                      BlastDirectionality.explosive,
                                  maxBlastForce: 2,
                                  minBlastForce: 1,
                                  emissionFrequency: 0.005,
                                  numberOfParticles: 4,
                                  gravity: 0.1,
                                ),
                              ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
        ], // Stack children
      ),
    );
  }
}
