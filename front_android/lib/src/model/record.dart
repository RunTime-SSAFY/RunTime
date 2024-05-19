class Record {
  String? courseImgUrl;
  int? id;
  String? runStartTime;
  String? runEndTime;
  String? gameMode;
  int? ranking;
  double? distance;
  int? averagePace;
  int? calorie;
  int? duration;

  Record(
      {this.courseImgUrl,
      this.id,
      this.runStartTime,
      this.runEndTime,
      this.gameMode,
      this.ranking,
      this.distance,
      this.averagePace,
      this.calorie,
      this.duration});

  Record.fromJson(Map<String, dynamic> json) {
    if (json["courseImgUrl"] is String) {
      courseImgUrl = json["courseImgUrl"];
    }
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["runStartTime"] is String) {
      runStartTime = json["runStartTime"];
    }
    if (json["runEndTime"] is String) {
      runEndTime = json["runEndTime"];
    }
    if (json["gameMode"] is String) {
      gameMode = json["gameMode"];
    }
    if (json["ranking"] is int) {
      ranking = json["ranking"];
    }
    if (json["distance"] is double) {
      distance = json["distance"];
    }
    if (json["averagePace"] is int) {
      averagePace = json["averagePace"];
    }
    if (json["calorie"] is int) {
      calorie = json["calorie"];
    }
    if (json["duration"] is int) {
      duration = json["duration"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["courseImgUrl"] = courseImgUrl;
    _data["id"] = id;
    _data["runStartTime"] = runStartTime;
    _data["runEndTime"] = runEndTime;
    _data["gameMode"] = gameMode;
    _data["ranking"] = ranking;
    _data["distance"] = distance;
    _data["averagePace"] = averagePace;
    _data["calorie"] = calorie;
    _data["duration"] = duration;
    return _data;
  }
}
