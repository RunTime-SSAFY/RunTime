import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/repository/record_repository.dart';

final recordViewModelProvider =
    ChangeNotifierProvider((ref) => RecordViewModel());

class RecordViewModel extends ChangeNotifier {
  var recordRepository = RecordRepository();

  // 게임모드 getter, setter
  String? _gameMode;
  String? get gameMode => _gameMode;
  set gameMode(String? gameMode) {
    recordRepository.clearRecordList();
    _gameMode = gameMode;
    notifyListeners();
  }

  // 받은 데이터
  List<Record> get recordList => recordRepository.recordList;
  int? get lastId => recordRepository.lastId;
  bool get hasNext => recordRepository.hasNext;
  Record? get record => recordRepository.record;

  // 로딩
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 기록 리스트 가져오기
  Future<void> fetchRecordList({
    required int pageSize,
    required int? lastId,
    required String? gameMode,
  }) async {
    _isLoading = true;
    await recordRepository.fetchRecordList(pageSize, lastId, gameMode);
    _isLoading = false;
    notifyListeners();
  }

  // 기록 초기화
  void clearRecordList() {
    recordRepository.clearRecordList();
    notifyListeners();
  }
}
