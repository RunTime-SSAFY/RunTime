import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/ranking.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/text_clip_horizontal.dart';
import 'package:front_android/util/helper/tier_helper.dart';
import 'package:overflow_text_animated/overflow_text_animated.dart';
import 'package:table_calendar/table_calendar.dart';

class RankingListCard extends ConsumerWidget {
  const RankingListCard({
    required this.rank,
    required this.ranking,
    super.key,
  });

  final int rank;
  final Ranking ranking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color backgroundColor1;
    Color backgroundColor2;
    TextStyle textStyle1 = TextStyle(color: ref.color.white);
    TextStyle textStyle2 = TextStyle(color: ref.color.white);

    switch (rank) {
      case 1:
        backgroundColor1 = ref.palette.gray900;
        backgroundColor2 = ref.palette.gray700;
        break;
      case 2:
        backgroundColor1 = ref.palette.gray800;
        backgroundColor2 = ref.palette.gray600;
        break;
      case 3:
        backgroundColor1 = ref.palette.gray700;
        backgroundColor2 = ref.palette.gray500;
        break;
      default:
        backgroundColor1 = ref.palette.gray100;
        backgroundColor2 = ref.palette.gray100;
        textStyle1 = textStyle1.copyWith(
            color: ref.palette.gray600, fontWeight: FontWeight.normal);
        textStyle2 = textStyle2.copyWith(color: ref.color.black);
    }

    return Padding(
      // Navigator.pushNamed(context, RoutePath.recordDetail);
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              backgroundColor1,
              backgroundColor2,
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
        child: Stack(
          children: [
            // 티어
            Positioned(
              right: -20,
              bottom: -64,
              child: Image.network(
                ranking.tierImage,
                width: 200,
              ),
            ),

            // 랭크 및 닉네임
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  // 랭크
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        '$rank',
                        style: textStyle1.copyWith(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  // 닉네임
                  Expanded(
                    flex: 5,
                    child: OverflowTextAnimated(
                      // text: isFinal ? 'MAX' : 'LV.$grade',
                      text: ranking.nickname,
                      style: textStyle2.copyWith(
                        fontSize: 26,
                      ),
                      curve: Curves.fastEaseInToSlowEaseOut,
                      animation: OverFlowTextAnimations.scrollOpposite,
                      animateDuration: const Duration(milliseconds: 1500),
                      delay: const Duration(milliseconds: 500),
                    ),
                  ),

                  // flex 4의 공간
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                ],
              ),
            ),

            // 티어 이름 및 점수를 위한 공간 분리
            Positioned.fill(
              bottom: 5,
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    // 티어 이름 및 점수
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextClipHorizontal(
                          child: Text(
                            TierHelper.getTier(ranking.tierName),
                            style: textStyle2.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        TextClipHorizontal(
                          child: Text(
                            '${ranking.tierScore}점',
                            style: textStyle2.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// ListView.builder(
//               itemCount: rankings.length,
//               itemBuilder: (context, index) {
//                 final ranking = rankings[index];
//                 final rank = (index + 1);
//                 Color color;
//                 Color fontColor = const Color(0xffffffff);
//                 FontWeight fontWeight = FontWeight.bold;
//                 Color nameColor = const Color(0xffffffff);
//                 if (rank == 1) {
//                   color = const Color(0xff1A202C);
//                 } else if (rank == 2) {
//                   color = const Color(0xff2D3748);
//                 } else if (rank == 3) {
//                   color = const Color(0xff4A5568);
//                 } else {
//                   color = const Color(0xffffffff); // 기본 색상
//                   fontColor = const Color(0xff718096);
//                   nameColor = const Color(0xff000000);
//                   fontWeight = FontWeight.normal;
//                 }
//                 return Container(
//                   height: 100,
//                   margin: const EdgeInsets.all(10),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: color,

//                     //color: Colors.grey.shade300,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       // 등수
//                       Container(
//                         width: 40,
//                         alignment: Alignment.center,
//                         child: Text(
//                           rank.toString(),
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: fontWeight,
//                             color: fontColor,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 10),

//                       // 닉네임
//                       Expanded(
//                         child: Text(
//                           ranking.nickname,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                             color: nameColor,
//                           ),
//                         ),
//                       ),
//                       // 티어 이미지
//                       Stack(
//                         children: [
//                           Positioned(
//                               child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Image.network(
//                               ranking.tierImage,
//                               fit: BoxFit.cover,
//                               height: 100.0,
//                               width: 150.0,
//                             ),
//                           )),
//                           Positioned(
//                             child: Column(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     ranking.tierName,
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: nameColor,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     ranking.tierScore.toString(),
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: nameColor,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           //const SizedBox(width: 20),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),