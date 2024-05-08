import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record_list_model.dart';
import 'package:front_android/src/repository/record_repository.dart';

final recordViewModelProvider =
    ChangeNotifierProvider((ref) => RecordViewModel());

class RecordViewModel extends ChangeNotifier {
  var recordRepository = RecordRepository();

  RecordListModel get recordList => recordRepository.recordListModel;
  // final RecordRepository recordRepository;

  // getRecordList();
}
