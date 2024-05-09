import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/record/record_detail_view.dart';
import 'package:go_router/go_router.dart';

final List<String> dataList = [];

class RecordList extends ConsumerWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: const [
        ActivityCard(
          mode: "대결모드",
          date: "4월 5일 19:30",
          type: "rrr",
          status: "승리",
          distance: "3Km",
          duration: "16분 37초",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        ),
        ActivityCard(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          mode: "대결모드",
          date: "4월 5일 19:30",
          type: "rrr",
          status: "승리",
          distance: "3Km",
          duration: "16분 37초",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        ),
        ActivityCard(
          mode: "연습모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          mode: "사용자모드",
          date: "4월 5일 19:30",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "16분 37초",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        ),
        ActivityCard(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
      ],
    );
  }
}

class ActivityCard extends ConsumerWidget {
  final String mode;
  final String date;
  final String type;
  final String status;
  final String distance;
  final String duration;
  final Color backgroundColor;
  final Color textColor;

  const ActivityCard({
    super.key,
    required this.mode,
    required this.date,
    required this.type,
    required this.status,
    required this.distance,
    required this.duration,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  date.split(" ")[0] + " " + date.split(" ")[1],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date.split(" ")[2],
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
              mode: mode,
              date: date,
              type: type,
              status: status,
              distance: distance,
              duration: duration,
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
  final String mode;
  final String date;
  final String type;
  final String status;
  final String distance;
  final String duration;
  final Color backgroundColor;
  final Color textColor;

  const RecordListItemCard({
    super.key,
    required this.mode,
    required this.date,
    required this.type,
    required this.status,
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
        GoRouter.of(context).push('/record/detail');
        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(builder: (context) => const RecordDetailView()),
        // );
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
                // <Widget> 은 무엇을 의미하는가?
                Row(
                  children: [
                    Text(mode,
                        style: ref.typo.headline2.copyWith(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(width: 10),

                    // status가 존재하면 상태를 표시
                    status.isNotEmpty
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
                                status,
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
                    distance,
                    style: ref.typo.headline2.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    duration,
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
