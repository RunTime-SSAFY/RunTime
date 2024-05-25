import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late ConfettiController _confettiController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getReward(widget.data.typeId);
      print(viewModel.achievementList);

      _confettiController = ConfettiController(
        duration: const Duration(seconds: 3),
      );
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(achievementProvider);
    _confettiController.play();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 40),
                      // 캐릭터 이미지
                      Image.network(
                        widget.data.characterImgUrl,
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 40),
                      // 캐릭터 이름
                      Text(
                        widget.data.characterName,
                        style: ref.typo.headline1.copyWith(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '캐릭터 잠금 해제',
                        style: ref.typo.subTitle2
                            .copyWith(color: ref.color.accept),
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

          // Confetti
          Positioned.fill(
            left: 0,
            top: 150,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 4,
              maxBlastForce: 50, // set a lower max blast force
              minBlastForce: 1, // set a lower min blast force
              emissionFrequency: 0.02,
              numberOfParticles: 5, // a lot of particles at once
              gravity: 1,
              shouldLoop: true,

              // particleDrag: 0.001,
              // canvas: MediaQuery.of(context).size,
            ),
          ),
          Positioned.fill(
            left: 0,
            top: 100,
            child: Align(
              alignment: Alignment.topRight,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi,
                maxBlastForce: 80, // set a lower max blast force
                minBlastForce: 1, // set a lower min blast force
                emissionFrequency: 0.02,
                numberOfParticles: 5, // a lot of particles at once
                gravity: 1,
                shouldLoop: true,
                // particleDrag: 0.001,
                // canvas: MediaQuery.of(context).size,
              ),
            ),
          ),

          // left: pi, down: pi / 2, right: 0, up: -pi / 2
        ],
      ),
    );
  }
}
