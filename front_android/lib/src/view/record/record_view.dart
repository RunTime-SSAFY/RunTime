import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp(home: RecordView())));
}

final dateProvider = StateProvider.autoDispose<DateInfo>((ref) {
  final today = DateTime.now();
  return DateInfo(today.year, today.month);
});

final selectedDateProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now(); // 초기 선택된 날짜는 오늘 날짜로 설정
});

class DateInfo {
  final int year;
  final int month;

  DateInfo(this.year, this.month);
}

class RecordView extends ConsumerWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.record,
          style: ref.typo.appBarMainTitle,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: SvgIcon('bell'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Consumer(
              builder: (context, ref, _) {
                final dateInfo = ref.watch(dateProvider);
                return Text('${dateInfo.year}년 ${dateInfo.month}월',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold));
              },
            ),
          ),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CenteredTimeline(),
            ),
          ),
        ],
      ),
    );
  }
}

class CenteredTimeline extends ConsumerStatefulWidget {
  const CenteredTimeline({Key? key}) : super(key: key);

  @override
  ConsumerState<CenteredTimeline> createState() => _CenteredTimelineState();
}

class _CenteredTimelineState extends ConsumerState<CenteredTimeline> {
  final ScrollController _scrollController = ScrollController();
  final double itemWidth = 80.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final daysPast =
          DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
      final initialScroll = daysPast * itemWidth -
          MediaQuery.of(context).size.width / 2 +
          itemWidth / 2;
      _scrollController.jumpTo(initialScroll);
      _scrollController.addListener(centerDateUpdate);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(centerDateUpdate);
    _scrollController.dispose();
    super.dispose();
  }

  void centerDateUpdate() {
    final centerOffset =
        _scrollController.offset + MediaQuery.of(context).size.width / 2;
    final centerIndex = (centerOffset / itemWidth).floor();
    final centerDate = DateTime.now().subtract(Duration(days: centerIndex));
    ref.read(selectedDateProvider.notifier).state = centerDate;
  }

  @override
  Widget build(BuildContext context) {
    final daysPast =
        DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: daysPast + 1,
      reverse: true,
      itemBuilder: (context, index) {
        final date = DateTime.now().subtract(Duration(days: index));
        return Consumer(
          builder: (context, ref, _) {
            final selectedDate = ref.watch(selectedDateProvider);
            final isSelected = selectedDate.isAtSameMomentAs(date);
            return CenteredDateWidget(
                date: date, width: itemWidth, isSelected: isSelected);
          },
        );
      },
    );
  }
}

class CenteredDateWidget extends StatelessWidget {
  final DateTime date;
  final double width;
  final bool isSelected;

  const CenteredDateWidget(
      {Key? key,
      required this.date,
      required this.width,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      decoration: isSelected
          ? BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10))
          : null,
      child: Text(
        DateFormat('d').format(date),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }
}
