// 통계 리스트
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/statistic.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/helper/number_format_helper.dart';

class StatisticCard extends ConsumerWidget {
  // titleColor: ref.palette.gray600,
  // valueColor: ref.palette.gray900,
  // titleColor: ref.palette.gray600,
  // valueColor: ref.palette.white,
  final DateTime? selectedDate;
  final Statistic? statistic;
  final Color backgroundColor1; // 200, 900
  final Color backgroundColor2; // 200, 800
  final Color textColor1;
  final Color textColor2;

  const StatisticCard({
    required this.selectedDate,
    required this.statistic,
    required this.backgroundColor1,
    required this.backgroundColor2,
    required this.textColor1,
    required this.textColor2,
    super.key,
  });
  // 데이터

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = "";
    String countDay = '${statistic?.countDay ?? 0}일';
    String calorie = '${NumberFormatHelper.comma(statistic?.calorie ?? 0)}kcal';
    String distance =
        '${NumberFormatHelper.comma(statistic?.distance?.truncate() ?? 0)}km';
    String duration =
        '${((statistic?.duration ?? 1) / 1000 / 60 / 60).truncate()}시간';
    // 타입에 따라 title 형식 변경
    switch (statistic!.type) {
      case 'ALL':
        title = '전체통계';
        break;
      case 'YEAR':
        title = '${selectedDate?.year}년의 통계';
        break;
      case 'MONTH':
        title = '${selectedDate?.month}월의 통계';
        break;
    }

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
            ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 타이틀
              Text(title,
                  style: ref.typo.headline1.copyWith(color: textColor1)),
              // 달린일수, 총 칼로리
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: StatisticInfoItem(
                      title: '달린 일수',
                      value: countDay,
                      titleColor: textColor2,
                      valueColor: textColor1,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticInfoItem(
                      title: '소모한 칼로리',
                      value: calorie,
                      titleColor: textColor2,
                      valueColor: textColor1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 총 거리, 총 시간
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: StatisticInfoItem(
                      title: '달린 거리',
                      value: distance,
                      titleColor: textColor2,
                      valueColor: textColor1,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticInfoItem(
                      title: '달린 시간',
                      value: duration,
                      titleColor: textColor2,
                      valueColor: textColor1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatisticInfoItem extends ConsumerWidget {
  const StatisticInfoItem({
    required this.title,
    required this.value,
    this.titleColor,
    this.valueColor,
    super.key,
  });

  final String title;
  final String value;
  final Color? titleColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: ref.typo.subTitle4.copyWith(color: titleColor)),
        Text(value, style: ref.typo.headline1.copyWith(color: valueColor)),
      ],
    );
  }
}
