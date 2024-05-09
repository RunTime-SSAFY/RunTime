import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/record/widgets/statistics/statistics_card.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class StatisticsView extends ConsumerWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
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
      body: Expanded(
        child: ListView(
          children: const [
            StatisticsCalendar(),
            SizedBox(height: 20),
            StatisticsCard1(),
            SizedBox(height: 20),
            StatisticsCard2(),
            SizedBox(height: 20),
            StatisticsCard3(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
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
