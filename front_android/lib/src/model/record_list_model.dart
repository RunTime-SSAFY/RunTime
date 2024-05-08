import 'package:front_android/src/model/record_model.dart';

class RecordListModel {
  final List<RecordModel> recordList;
  final bool hasNext;
  final int lastId;

  RecordListModel({
    required this.recordList,
    required this.hasNext,
    required this.lastId,
  });
}
