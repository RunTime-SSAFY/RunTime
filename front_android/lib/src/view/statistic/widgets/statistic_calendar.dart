import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/statistic/statistic_view_model.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class StatisticCalendar extends ConsumerStatefulWidget {
  const StatisticCalendar({super.key});

  @override
  ConsumerState<StatisticCalendar> createState() => _StatisticCalendarState();
}

class _StatisticCalendarState extends ConsumerState<StatisticCalendar> {
  late StatisticViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(statisticViewModelProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.now(),
        focusedDay: viewModel.focusedDay ?? DateTime.now(),
        daysOfWeekHeight: 40,

        // 헤더 스타일
        headerStyle: HeaderStyle(
          titleCentered: true,
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMMM(locale).format(date),
          formatButtonVisible: false,
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
          ),
          headerPadding: const EdgeInsets.symmetric(vertical: 4.0),
        ),

        // 캘린더 스타일
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          // todayDecoration: BoxDecoration(
          //   color: ref.color.accept,
          //   shape: BoxShape.circle,
          // ),
          isTodayHighlighted: false,
          // todayTextStyle: ref.typo.body1,
          defaultTextStyle: ref.typo.body1,
          weekendTextStyle: ref.typo.body1,
        ),
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday) {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: ref.palette.red400),
                ),
              );
            } else if (day.weekday == DateTime.saturday) {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: ref.palette.blue400),
                ),
              );
            } else {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text,
                  style: ref.typo.body1,
                ),
              );
            }
          },
          defaultBuilder: (context, day, focusedDay) {
            if (day.weekday == DateTime.sunday) {
              return Center(
                child: Text(
                  '${day.day}',
                  style: ref.typo.body1.copyWith(color: ref.palette.red400),
                ),
              );
            } else if (day.weekday == DateTime.saturday) {
              return Center(
                child: Text(
                  '${day.day}',
                  style: ref.typo.body1.copyWith(color: ref.palette.blue400),
                ),
              );
            } else {
              return Center(
                child: Text(
                  '${day.day}',
                  style: ref.typo.body1,
                ),
              );
            }
          },
          markerBuilder: (context, day, events) {
            if (viewModel.runDateList?.contains(day.day) ?? false) {
              return Positioned(
                bottom: 4,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: ref.color.accept,
                    shape: BoxShape.circle,
                    // borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        onPageChanged: (focusedDay) {
          viewModel.focusedDay = focusedDay;
          // 연도와 달을 콘솔에 출력
          // print('현재 보고 있는 연도: ${focusedDay.year}, 달: ${focusedDay.month}');

          // 연도와 달을 이용해 통계 데이터를 업데이트함
          viewModel.fetchStatistic("MONTH", viewModel.focusedDay!);
          // 1월이나 12월일 경우에만 연도 통계 데이터를 업데이트함
          if (viewModel.focusedDay!.month == 1 ||
              viewModel.focusedDay!.month == 12) {
            viewModel.fetchStatistic("YEAR", viewModel.focusedDay!);
          }
        },
      ),
    );
  }
}
