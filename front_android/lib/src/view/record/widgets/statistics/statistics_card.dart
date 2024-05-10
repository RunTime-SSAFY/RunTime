// 통계 리스트
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class StatisticsCard1 extends ConsumerWidget {
  const StatisticsCard1({super.key});
  // 데이터

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      // 실제 보이는 카드 모양 시작
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ref.palette.gray200,
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
              Text('4월의 통계',
                  style:
                      ref.typo.headline1.copyWith(color: ref.palette.gray900)),
              // 달린일수, 총 칼로리
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '달린 일수',
                      value: '448 일',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '총 칼로리',
                      value: '80,361 kcal',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
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
                    child: StatisticsInfoItem(
                      title: '총 거리',
                      value: '8,872 km',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '총 시간',
                      value: '5일 3시간',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
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

class StatisticsCard2 extends ConsumerWidget {
  const StatisticsCard2({super.key});
  // 데이터

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      // 실제 보이는 카드 모양 시작
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ref.palette.gray200,
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
              Text('2024년의 통계',
                  style:
                      ref.typo.headline1.copyWith(color: ref.palette.gray900)),
              // 달린일수, 총 칼로리
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '달린 일수',
                      value: '448 일',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '총 칼로리',
                      value: '80,361 kcal',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
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
                    child: StatisticsInfoItem(
                      title: '총 거리',
                      value: '8,872 km',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '총 시간',
                      value: '5일 3시간',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.palette.gray900,
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

class StatisticsCard3 extends ConsumerWidget {
  const StatisticsCard3({super.key});
  // 데이터

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ref.palette.gray900,
                ref.palette.gray800,
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
              Text('전체통계',
                  style: ref.typo.headline1.copyWith(color: ref.color.white)),
              // 달린일수, 총 칼로리
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '달린 일수',
                      value: '448 일',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.color.white,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '총 칼로리',
                      value: '80,361 kcal',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.color.white,
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
                    child: StatisticsInfoItem(
                      title: '총 거리',
                      value: '8,872 km',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.color.white,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: StatisticsInfoItem(
                      title: '총 시간',
                      value: '5일 3시간',
                      titleColor: ref.palette.gray600,
                      valueColor: ref.color.white,
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

class StatisticsInfoItem extends ConsumerWidget {
  const StatisticsInfoItem({
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
