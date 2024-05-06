import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/view/record/record_view_model.dart';
import 'package:intl/intl.dart'; // 날짜 형식 지정을 위한 라이브러리
import 'package:front_android/src/service/theme_service.dart'; // 테마 서비스를 위한 라이브러리

// 사용자 정의 위젯 및 로컬라이제이션을 위한 import
import 'package:front_android/theme/components/bottom_navigation.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

// 연도와 월 정보를 보유하는 클래스
class DateInfo {
  final int year;
  final int month;

  DateInfo(this.year, this.month);
}

// Column

// 화면에 표시되는 날짜의 연도와 월을 관리하는 프로바이더
final dateProvider = StateProvider.autoDispose<DateInfo>((ref) {
  final today = DateTime.now();
  return DateInfo(today.year, today.month);
});

// 선택된 날짜를 관리하는 프로바이더
final selectedDateProvider = StateProvider.autoDispose<DateTime>((ref) {
  return DateTime.now(); // 초기 선택된 날짜는 오늘 날짜로 설정
});

// 기록을 표시하는 위젯
class RecordView extends ConsumerWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // RecordViewModel viewModel = ref.watch(recordViewModelProvider); // 뷰 모델 가져오기
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
                final dateInfo = ref.watch(dateProvider); // 현재 날짜 정보 가져옴
                return Text('${dateInfo.year}년 ${dateInfo.month}월', // 연도와 월 표시
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold));
              },
            ),
          ),
          const SizedBox(
            height: 100,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CenteredTimeline(), // 중앙 정렬된 타임라인 위젯
            ),
          ),
          ListView(
            // padding: const EdgeInsets.all(8),
            children: const <Widget>[
              ActivityCard(
                date: "4월 5일 19:30",
                type: "대중교통",
                status: "승차",
                distance: "3Km",
                duration: "16분 37초",
                backgroundColor: Colors.black87,
                textColor: Colors.white,
              ),
              ActivityCard(
                date: "4월 4일 20:00",
                type: "사용자도로",
                status: "",
                distance: "3Km",
                duration: "17분 37초",
                backgroundColor: Colors.white,
                textColor: Colors.black87,
              ),
              ActivityCard(
                date: "4월 2일 18:10",
                type: "대중교통",
                status: "패배",
                distance: "3Km",
                duration: "16분 37초",
                backgroundColor: Colors.black87,
                textColor: Colors.white,
              ),
              ActivityCard(
                date: "3월 27일 22:40",
                type: "대중교통",
                status: "승차",
                distance: "3Km",
                duration: "16분 37초",
                backgroundColor: Colors.black87,
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationWidget(), // 사용자 정의 하단 네비게이션 위젯
    );
  }
}

// 가운데 정렬된, 수평으로 스크롤 가능한 타임라인을 표시하는 위젯
class CenteredTimeline extends ConsumerStatefulWidget {
  const CenteredTimeline({super.key});

  @override
  ConsumerState<CenteredTimeline> createState() => _CenteredTimelineState();
}

// 가운데 정렬된 타임라인 위젯의 상태 클래스
class _CenteredTimelineState extends ConsumerState<CenteredTimeline> {
  final ScrollController _scrollController = ScrollController();
  final double itemWidth = 80.0; // 각 날짜 항목의 너비

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final daysPast = DateTime.now()
          .difference(DateTime(DateTime.now().year, 1, 1))
          .inDays; // 현재 연도의 경과된 날짜 계산
      final initialScroll = daysPast * itemWidth -
          MediaQuery.of(context).size.width / 2 +
          itemWidth / 2; // 오늘 날짜를 중앙에 위치시키기 위한 초기 스크롤 위치 계산
      _scrollController.jumpTo(initialScroll); // 초기 스크롤 위치 설정
      _scrollController.addListener(centerDateUpdate); // 스크롤 변경 감지를 위한 리스너 추가
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(centerDateUpdate); // 메모리 누수 방지를 위해 리스너 제거
    _scrollController.dispose(); // 스크롤 컨트롤러 해제
    super.dispose();
  }

  // 가운데 항목에 해당하는 날짜를 기준으로 선택된 날짜 업데이트
  void centerDateUpdate() {
    final centerOffset = _scrollController.offset +
        MediaQuery.of(context).size.width / 2; // 가운데 오프셋 계산
    final centerIndex = (centerOffset / itemWidth).floor(); // 가운데 항목의 인덱스 계산
    final centerDate = DateTime.now()
        .subtract(Duration(days: centerIndex)); // 가운데 항목에 해당하는 날짜 계산
    ref.read(selectedDateProvider.notifier).state = centerDate; // 선택된 날짜 업데이트
  }

  @override
  Widget build(BuildContext context) {
    final daysPast = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays; // 현재 연도의 경과된 날짜 계산
    return ListView.builder(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      itemCount: daysPast + 1, // 타임라인 전체 항목 수
      reverse: true,
      itemBuilder: (context, index) {
        final date =
            DateTime.now().subtract(Duration(days: index)); // 현재 항목에 해당하는 날짜 계산
        return Consumer(
          builder: (context, ref, _) {
            final selectedDate = ref.watch(selectedDateProvider); // 선택된 날짜 가져오기
            final isSelected =
                selectedDate.isAtSameMomentAs(date); // 현재 날짜가 선택되었는지 확인
            return CenteredDateWidget(
                date: date,
                width: itemWidth,
                isSelected: isSelected); // 가운데 정렬된 날짜 위젯 표시
          },
        );
      },
    );
  }
}

// 가운데 정렬된 날짜를 표시하는 위젯
class CenteredDateWidget extends StatelessWidget {
  final DateTime date;
  final double width;
  final bool isSelected;

  const CenteredDateWidget({
    super.key,
    required this.date,
    required this.width,
    this.isSelected = false,
  });

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
        DateFormat('d').format(date), // 날짜 형식 지정하여 날짜 표시
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.blue : Colors.black, // 선택된 경우 텍스트 색상 변경
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String date;
  final String type;
  final String status;
  final String distance;
  final String duration;
  final Color backgroundColor;
  final Color textColor;

  const ActivityCard({
    super.key,
    required this.date,
    required this.type,
    required this.status,
    required this.distance,
    required this.duration,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(date, style: TextStyle(color: textColor, fontSize: 16)),
            const SizedBox(height: 8),
            Text(type + (status.isNotEmpty ? " - $status" : ""),
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(distance,
                    style: TextStyle(color: textColor, fontSize: 18)),
                Text(duration,
                    style: TextStyle(color: textColor, fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
