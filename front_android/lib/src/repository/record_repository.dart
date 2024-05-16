import 'package:flutter/material.dart';
import 'package:front_android/src/model/record.dart';
import 'package:front_android/src/model/record_list_response.dart';
import 'package:front_android/src/service/https_request_service.dart';

class RecordRepository {
  var api = apiInstance;

  bool hasNext = true;
  int? lastId;
  List<Record> recordList = [];

  RecordListResponse recordListResponse = RecordListResponse();

  Future<void> fetchRecordList(
      int pageSize, int? lastId, String? gameMode) async {
    try {
      final response = await api.get("/api/records", queryParameters: {
        "pageSize": pageSize,
        "lastId": lastId,
        "gameMode": gameMode,
      });
      print("--------[RecordRepository] fetchRecordList --------");
      print(response.data);
      recordListResponse = RecordListResponse.fromJson(response.data);
      // recordList에 계속 추가
      recordList.addAll(recordListResponse.recordList!);
      hasNext = recordListResponse.hasNext!;
      this.lastId = recordListResponse.lastId!;
      print("--------[RecordRepository] fetchRecordList --------");
      print(recordListResponse);
    } catch (e, s) {
      debugPrint('에러 발생 $e, $s');
      throw Error();
    }
  }

  //record id로 record 조회
  Future<Record> getRecordById(int recordId) async {
    try {
      final response = await api.get("/api/records/$recordId");
      return Record.fromJson(response.data);
    } catch (e, s) {
      debugPrint('에러 발생 $e, $s');
      throw Error();
    }
  }

  // recordList 초기화
  void clearRecordList() {
    recordList = [];
    hasNext = true;
    lastId = null;
  }
}
