import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/repository/record_repository.dart';

final recordDetailViewModelProvider =
    ChangeNotifierProvider((ref) => RecordDetailViewModel());

class RecordDetailViewModel extends ChangeNotifier {
  var recordRepository = RecordRepository();

  // 받은 데이터
  Record? get record => recordRepository.record;

  // 로딩
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 기록 가져오기
  Future<void> getRecord(int recordId) async {
    _isLoading = true;
    await recordRepository.getRecord(recordId);
    _isLoading = false;
    notifyListeners();
  }
}
