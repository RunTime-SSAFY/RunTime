class Record {
  int? id;
  String? runStartTime;
  int? duration;
  String? gameMode;
  int? ranking;
  double? distance;

  Record(
      {this.id,
      this.runStartTime,
      this.duration,
      this.gameMode,
      this.ranking,
      this.distance});

  Record.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["runStartTime"] is String) {
      runStartTime = json["runStartTime"];
    }
    if (json["duration"] is int) {
      duration = json["duration"];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["runStartTime"] = runStartTime;
    _data["duration"] = duration;
    _data["gameMode"] = gameMode;
    _data["ranking"] = ranking;
    _data["distance"] = distance;
    return _data;
  }
}
