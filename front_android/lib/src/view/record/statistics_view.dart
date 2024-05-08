import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class StatisticsView extends ConsumerWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: ref.color.black,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          S.current.statistics,
          style: ref.typo.appBarSubTitle,
        ),
        actions: [],
      ),
      body: const Column(
        children: [
          StatisticsCalendar(),
          StatisticsList(),
        ],
      ),
    );
  }

  // return CupertinoPageScaffold(
  //   navigationBar: CupertinoNavigationBar(
  //     middle: Text(
  //       S.current.statistics,
  //       style: ref.typo.appBarSubTitle,
  //     ),
  //   ),
  //   child: const Padding(
  //     padding: const EdgeInsets.only(
  //       top: 84,
  //     ),
  //     child: Column(
  //       children: [
  //         StatisticsCalendar(),
  //         StatisticsList(),
  //       ],
  //     ),
  //   ),
  // );
}

// 달력
class StatisticsCalendar extends ConsumerWidget {
  const StatisticsCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 높이 200의 임시 컨테이너
    return Container(
      height: 400,
      color: ref.palette.gray400,
    );

    // return Container(
    //   width:,
    //   height: 200,
    //   color: ref.palette.gray300,
    // );
  }
}

// 통계 리스트
class StatisticsList extends ConsumerWidget {
  const StatisticsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView(
        children: [
          StatisticsCard(),
        ],
      ),
    );
  }
}

class StatisticsCard extends ConsumerWidget {
  const StatisticsCard({super.key});
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('달린 일수',
                            style: ref.typo.subTitle4
                                .copyWith(color: ref.palette.gray600)),
                        Text('448 일',
                            style: ref.typo.headline1
                                .copyWith(color: ref.color.white)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('총 칼로리',
                            style: ref.typo.subTitle4
                                .copyWith(color: ref.palette.gray600)),
                        Text('80,361 kcal',
                            style: ref.typo.headline1
                                .copyWith(color: ref.color.white)),
                      ],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('총 거리',
                            style: ref.typo.subTitle4
                                .copyWith(color: ref.palette.gray600)),
                        Text('8,872 km',
                            style: ref.typo.headline1
                                .copyWith(color: ref.color.white)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('총 시간',
                            style: ref.typo.subTitle4
                                .copyWith(color: ref.palette.gray600)),
                        Text('5일 3시간',
                            style: ref.typo.headline1
                                .copyWith(color: ref.color.white)),
                      ],
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
