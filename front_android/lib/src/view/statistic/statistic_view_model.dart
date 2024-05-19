import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/statistic.dart';
import 'package:front_android/src/repository/record_repository.dart';

final statisticViewModelProvider =
    ChangeNotifierProvider((ref) => StatisticViewModel());

class StatisticViewModel extends ChangeNotifier {
  var recordRepository = RecordRepository();

  // field, getter, setter
  DateTime? _focusedDay = DateTime.now();
  DateTime? get focusedDay => _focusedDay;
  set focusedDay(DateTime? focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  // 받은 데이터
  Map<String, Statistic>? get statistic => recordRepository.statisticMap;
  List<int>? get runDateList =>
      recordRepository.statisticMap?['MONTH']?.runDateList;

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

  // 통계 가져오기
  Future<void> fetchStatistic(String type, DateTime selectedDate) async {
    await recordRepository.fetchStatistic(type, selectedDate);
    notifyListeners();
  }
}
