import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/statistic/statistic_view_model.dart';
import 'package:front_android/src/view/statistic/widgets/statistic_calendar.dart';
import 'package:front_android/src/view/statistic/widgets/statistic_card.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class StatisticView extends ConsumerStatefulWidget {
  const StatisticView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatisticViewState();
}

class _StatisticViewState extends ConsumerState<StatisticView> {
  late StatisticViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      DateTime date = DateTime.now();
      viewModel.fetchStatistic('ALL', date);
      viewModel.fetchStatistic('YEAR', date);
      viewModel.fetchStatistic('MONTH', date);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(statisticViewModelProvider);
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
      body: ListView(
        children: [
          const StatisticCalendar(),
          const SizedBox(height: 20),
          StatisticCard(
            selectedDate: viewModel.focusedDay,
            statistic: viewModel.statistic!['MONTH'],
            backgroundColor1: ref.palette.gray200,
            backgroundColor2: ref.palette.gray200,
            textColor1: ref.palette.gray900,
            textColor2: ref.palette.gray600,
          ),
          const SizedBox(height: 20),
          StatisticCard(
            selectedDate: viewModel.focusedDay,
            statistic: viewModel.statistic!['YEAR'],
            backgroundColor1: ref.palette.gray200,
            backgroundColor2: ref.palette.gray200,
            textColor1: ref.palette.gray900,
            textColor2: ref.palette.gray600,
          ),
          const SizedBox(height: 20),
          StatisticCard(
            selectedDate: viewModel.focusedDay,
            statistic: viewModel.statistic!['ALL'],
            backgroundColor1: ref.palette.gray900,
            backgroundColor2: ref.palette.gray800,
            textColor1: ref.color.white,
            textColor2: ref.palette.gray600,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
