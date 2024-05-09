import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_android/src/model/record_list_model.dart';
import 'package:front_android/src/model/record_model.dart';
import 'package:front_android/src/service/https_request_service.dart';

class RecordRepository {
  final dio = apiInstance;
  late RecordListModel recordListModel;

  Future<RecordModel> getRecordList() async {
    try {
      var response = await dio.get("/records?size=10&lastId=0");
      final json = jsonDecode(response.data) as Map<String, dynamic>;
      debugPrint(json.toString());
      return RecordModel.fromJson(json);
    } catch (e, s) {
      debugPrint('에러 발생 $e, $s');
      return RecordModel.fromJson({});
    }
  }
}
