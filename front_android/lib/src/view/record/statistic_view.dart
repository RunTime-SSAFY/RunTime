import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/record/widgets/statistic_card.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class StatisticView extends ConsumerWidget {
  const StatisticView({super.key});

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
          S.current.statistic,
          style: ref.typo.appBarSubTitle,
        ),
        actions: [],
      ),
      body: Expanded(
        child: ListView(
          children: const [
            StatisticCalendar(),
            SizedBox(height: 20),
            StatisticCard1(),
            SizedBox(height: 20),
            StatisticCard2(),
            SizedBox(height: 20),
            StatisticCard3(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// 달력
class StatisticCalendar extends ConsumerWidget {
  const StatisticCalendar({super.key});

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
