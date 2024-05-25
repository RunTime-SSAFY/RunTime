import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/model/record_detail.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/enum_to_name.dart';
import 'package:front_android/util/helper/number_format_helper.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/helper/date_time_format_helper.dart';
import 'package:go_router/go_router.dart';

class RecordListItem extends ConsumerWidget {
  final Record record;

  const RecordListItem({
    required this.record,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // record에서 mode, date, type, status, distance, duration, backgroundColor, textColor를 가져옴
    final recordId = record.id;
    final gameMode = record.gameMode;
    // 문자열 타입의 runStartTime을 날짜 객체로 변환
    final date = DateTime.parse(record.runStartTime!);
    final distance = record.distance;
    final duration = record.duration;
    final ranking = record.ranking;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  // '2024년 5월' 표시
                  // record.runStartTime을 날짜객체로 변환
                  // 날짜객체를 'yyyy년 MM월' 형식으로 변환

                  "${date.month}월 ${date.day}일",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${date.hour}:${date.minute}",
                  style: ref.typo.subTitle4.copyWith(
                    color: ref.palette.gray600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            // 왼쪽에 선을 그어주기 위한 코드
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: ref.palette.gray400))),
            // 기록 카드 위젯
            child: RecordListItemCard(
              recordId: recordId!,
              gameMode: gameMode!,
              ranking: ranking!,
              distance: distance!,
              duration: duration!,
            ),
          ),
        ),
      ],
    );
  }
}

class RecordListItemCard extends ConsumerWidget {
  final int recordId;
  final String gameMode;
  final int ranking;
  final double distance;
  final int duration;

  const RecordListItemCard({
    super.key,
    required this.recordId,
    required this.gameMode,
    required this.ranking,
    required this.distance,
    required this.duration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, Color> rankingColors = {
      "WIN": ref.palette.indigo600,
      "LOSE": ref.palette.red500,
      "CUSTOM": ref.palette.gray900,
      "PRACTICE": ref.palette.gray900,
    };

    // gameMode에 따라 배경색과 글자색을 다르게 설정
    Color backgroundColor1 = ref.palette.gray200;
    Color backgroundColor2 = ref.palette.gray200;
    Color textColor = ref.palette.gray900;
    bool isShowRank = false;
    Color rankingColor = rankingColors["CUSTOM"]!;

    switch (gameMode) {
      case "BATTLE":
        backgroundColor1 = ref.palette.gray900;
        backgroundColor2 = ref.palette.gray800;
        textColor = ref.color.white;
        isShowRank = true;
        rankingColor =
            ranking == 1 ? rankingColors["WIN"]! : rankingColors["LOSE"]!;
        break;
      case "CUSTOM":
        backgroundColor1 = ref.palette.gray200;
        backgroundColor2 = ref.palette.gray200;
        textColor = ref.palette.gray900;
        isShowRank = true;
        rankingColor = rankingColors["CUSTOM"]!;
        break;
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      // 카드 클릭 시 recordDetail로 이동
      onPressed: () {
        RecordDetail recordDetail = RecordDetail(
          recordId: recordId,
          backgroundColor1: backgroundColor1,
          backgroundColor2: backgroundColor2,
          textColor: textColor,
          isShowRank: isShowRank,
          rankingColor: rankingColor,
        );

        print("-----recordStyle------");
        print(recordDetail);
        context.push(
          RoutePathHelper.recordDetail,
          extra: recordDetail,
        );
      },
      child: Padding(
        // Navigator.pushNamed(context, RoutePath.recordDetail);
        padding:
            const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      EnumToName.getGameMode(gameMode),
                      style: ref.typo.headline2.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // status가 존재하면 상태를 표시
                    isShowRank
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: rankingColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 8,
                                left: 8,
                                top: 3,
                                bottom: 3,
                              ),
                              child: Text(
                                gameMode == "BATTLE"
                                    ? (ranking == 1 ? "승리" : "패배")
                                    : "$ranking위",
                                style: ref.typo.subTitle5.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: ref.color.white,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${NumberFormatHelper.floatTrunk(distance)}km",
                    style: ref.typo.headline2.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateTimeFormatHelper.formatMilliseconds(duration),
                    // duration(milliseconds)을 시간, 분, 초로변환
                    // duration을 '시간:분:초' 형식으로 변환
                    style: ref.typo.subTitle3.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
