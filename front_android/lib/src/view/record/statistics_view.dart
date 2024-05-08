import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/svg_icon.dart';
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
    return Center();
  }
}

class StatisticsCard extends ConsumerWidget {
  const StatisticsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
