import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record_detail.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/enum_to_name.dart';

class RecordDetailTop extends ConsumerWidget {
  final String gameMode;
  final int ranking;
  final RecordDetail recordDetail;

  const RecordDetailTop({
    super.key,
    required this.gameMode,
    required this.ranking,
    required this.recordDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color backgroundColor1 = recordDetail.backgroundColor1;
    Color backgroundColor2 = recordDetail.backgroundColor2;
    Color textColor = recordDetail.textColor;
    bool isShowRank = recordDetail.isShowRank;
    Color rankingColor = recordDetail.rankingColor;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      // 실제 보이는 카드 모양 시작
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            // space
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 타이틀
              Text(
                EnumToName.getGameMode(gameMode),
                style: ref.typo.headline1.copyWith(color: textColor),
              ),

              // ranking
              if (isShowRank)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: rankingColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      left: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      gameMode == "BATTLE"
                          ? (ranking == 1 ? "승리" : "패배")
                          : "$ranking위",
                      style: ref.typo.subTitle4.copyWith(
                        fontWeight: ref.typo.bold,
                        color: ref.color.white,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
