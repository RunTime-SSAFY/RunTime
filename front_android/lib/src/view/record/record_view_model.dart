import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/repository/record_repository.dart';

final recordViewModelProvider =
    ChangeNotifierProvider((ref) => RecordViewModel());

class RecordViewModel extends ChangeNotifier {
  var recordRepository = RecordRepository();

  List<Record> get recordList => recordRepository.recordList;
  int get lastId => recordRepository.lastId;
  bool get hasNext => recordRepository.hasNext;

  // 기록 리스트 가져오기
  void fetchRecordList({
    required int pageSize,
    required int lastId,
    required String gameMode,
  }) async {
    await recordRepository.fetchRecordList(pageSize, lastId, gameMode);
    notifyListeners();
  }
}
