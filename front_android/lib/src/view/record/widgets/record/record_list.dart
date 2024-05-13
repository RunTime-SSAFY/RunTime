import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/view/record/widgets/record/record_list_item.dart';

final List<String> dataList = [];

class RecordList extends ConsumerWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: const [
        RecordListItem(
          mode: "대결모드",
          date: "4월 5일 19:30",
          type: "rrr",
          status: "승리",
          distance: "3Km",
          duration: "16분 37초",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        ),
        RecordListItem(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        RecordListItem(
          mode: "대결모드",
          date: "4월 5일 19:30",
          type: "rrr",
          status: "승리",
          distance: "3Km",
          duration: "16분 37초",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        ),
        RecordListItem(
          mode: "연습모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        RecordListItem(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        RecordListItem(
          mode: "사용자모드",
          date: "4월 5일 19:30",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "16분 37초",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        ),
        RecordListItem(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        RecordListItem(
          mode: "사용자모드",
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
      ],
    );
  }
}
