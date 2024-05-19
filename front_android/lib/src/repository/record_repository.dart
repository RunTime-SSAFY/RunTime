import 'package:flutter/material.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/model/record_list_response.dart';
import 'package:front_android/src/model/statistic.dart';
import 'package:front_android/src/service/https_request_service.dart';

class RecordRepository {
  var api = apiInstance;

  // field
  bool _hasNext = true;
  int? _lastId;
  List<Record> _recordList = [];
  Record? _record;
  final Map<String, Statistic> _statisticMap = {
    "ALL": Statistic(),
    "YEAR": Statistic(),
    "MONTH": Statistic(),
  };

  // getter
  bool get hasNext => _hasNext;
  int? get lastId => _lastId;
  List<Record> get recordList => _recordList;
  Record? get record => _record;
  Map<String, Statistic>? get statisticMap => _statisticMap;

  RecordListResponse recordListResponse = RecordListResponse();

  Future<void> fetchRecordList(
      int pageSize, int? lastId, String? gameMode) async {
    try {
      final response = await api.get(
        "/api/records",
        queryParameters: {
          "pageSize": pageSize,
          "lastId": lastId,
          "gameMode": gameMode,
        },
      );
      print("--------[RecordRepository] fetchRecordList --------");
      print(response.data);
      recordListResponse = RecordListResponse.fromJson(response.data);
      // recordList에 계속 추가
      _recordList.addAll(recordListResponse.recordList!);
      _hasNext = recordListResponse.hasNext!;
      _lastId = recordListResponse.lastId!;
      print("--------[RecordRepository] fetchRecordList --------");
      print(recordListResponse);
    } catch (e, s) {
      debugPrint('에러 발생 $e, $s');
      throw Error();
    }
  }

  //record id로 record 조회
  Future<void> getRecord(int recordId) async {
    try {
      final response = await api.get("/api/records/$recordId");
      _record = Record.fromJson(response.data);
    } catch (e, s) {
      debugPrint('에러 발생 $e, $s');
      throw Error();
    }
  }

  // statistic 조회
  Future<void> fetchStatistic(String type, DateTime selectedDate) async {
    try {
      final response = await api.get(
        "/api/records/statistics",
        queryParameters: {
          "type": type,
          "selectedDate": selectedDate.toIso8601String().split('T')[0],
        },
      );
      _statisticMap[type] = Statistic.fromJson(response.data);
      print("--------[RecordRepository] getStatistic --------");
      print(response.data);
      print("--------[RecordRepository] getStatistic --------");
    } catch (e, s) {
      debugPrint('에러 발생 $e, $s');
      throw Error();
    }
  }

  // recordList 초기화
  void clearRecordList() {
    _recordList = [];
    _hasNext = true;
    _lastId = null;
  }
}
