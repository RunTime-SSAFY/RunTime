import "package:front_android/src/model/record.dart";

class RecordListResponse {
  List<Record>? recordList;
  bool? hasNext;
  int? lastId;

  RecordListResponse({this.recordList, this.hasNext, this.lastId});

  RecordListResponse.fromJson(Map<String, dynamic> json) {
    if (json["recordList"] is List) {
      recordList = json["recordList"] == null
          ? null
          : (json["recordList"] as List)
              .map((e) => Record.fromJson(e))
              .toList();
    }
    if (json["hasNext"] is bool) {
      hasNext = json["hasNext"];
    }
    if (json["lastId"] is int) {
      lastId = json["lastId"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (recordList != null) {
      _data["recordList"] = recordList?.map((e) => e.toJson()).toList();
    }
    _data["hasNext"] = hasNext;
    _data["lastId"] = lastId;
    return _data;
  }
}
