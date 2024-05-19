import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/view/record/record_view_model.dart';
import 'package:front_android/src/view/record/widgets/record_list_item.dart';

class RecordList extends ConsumerStatefulWidget {
  const RecordList({
    required this.pageSize,
    required this.recordList,
    required this.hasNext,
    required this.lastId,
    required this.gameMode,
    super.key,
  });

  final int pageSize;
  final List<Record> recordList;
  final bool hasNext;
  final int? lastId;
  final String? gameMode;

  @override
  _RecordListState createState() => _RecordListState();
}

class _RecordListState extends ConsumerState<RecordList> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (widget.hasNext) {
        // 로딩 추가 데이터를 요청하는 함수를 호출
        // 예를 들면, 다음과 같은 함수를 호출할 수 있습니다: fetchMoreRecords();
        ref.read(recordViewModelProvider).fetchRecordList(
              pageSize: widget.pageSize,
              lastId: widget.lastId,
              gameMode: widget.gameMode,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.hasNext
          ? widget.recordList.length + 1
          : widget.recordList.length,
      itemBuilder: ((context, index) {
        if (index == widget.recordList.length && widget.hasNext) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return RecordListItem(
          record: widget.recordList[index],
        );
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
