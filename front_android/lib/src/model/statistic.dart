class Statistic {
  String? type;
  int? countDay;
  int? calorie;
  double? distance;
  int? duration;

  Statistic(
      {this.type, this.countDay, this.calorie, this.distance, this.duration});

  Statistic.fromJson(Map<String, dynamic> json) {
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["countDay"] is int) {
      countDay = json["countDay"];
    }
    if (json["calorie"] is int) {
      calorie = json["calorie"];
    }
    if (json["distance"] is double) {
      distance = json["distance"];
    }
    if (json["duration"] is int) {
      duration = json["duration"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["countDay"] = countDay;
    _data["calorie"] = calorie;
    _data["distance"] = distance;
    _data["duration"] = duration;
    return _data;
  }
}
