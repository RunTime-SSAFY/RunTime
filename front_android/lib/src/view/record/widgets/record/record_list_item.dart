import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

class RecordListItem extends ConsumerWidget {
  // String mode;
  // String date;
  // String type;
  // String status;
  // String distance;
  // String duration;
  // Color backgroundColor;
  // Color textColor;

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
    final backgroundColor = ref.color.white;
    final textColor = Colors.black;

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
              gameMode: gameMode!,
              ranking: ranking!,
              distance: distance!,
              duration: duration!,
              backgroundColor: backgroundColor,
              textColor: textColor,
            ),
          ),
        ),
      ],
    );
  }
}

class RecordListItemCard extends ConsumerWidget {
  final String gameMode;
  final int ranking;
  final double distance;
  final int duration;
  final Color backgroundColor;
  final Color textColor;

  const RecordListItemCard({
    super.key,
    required this.gameMode,
    required this.ranking,
    required this.distance,
    required this.duration,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        context.push(RoutePathHelper.recordDetail);
      },
      child: Padding(
        // Navigator.pushNamed(context, RoutePath.recordDetail);
        padding:
            const EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 2),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(gameMode,
                        style: ref.typo.headline2.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 10),

                    // status가 존재하면 상태를 표시
                    gameMode == "PRACTICE"
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: ref.color.accept,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                                top: 3,
                                bottom: 5,
                              ),
                              child: Text(
                                gameMode == "BATTLE"
                                    ? (ranking == 1 ? "우승" : "패배")
                                    : "$ranking위",
                                style: ref.typo.subTitle4.copyWith(
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
                    "$distance",
                    style: ref.typo.headline2.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "$duration",
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
