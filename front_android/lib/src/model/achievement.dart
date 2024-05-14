class Achievement {
  int? id;
  int? type;
  String? name;
  String? detail;
  String? criteria;
  int? grade;
  double? goal;
  double? prevGoal;
  double? progress;
  String? characterName;
  String? characterImgUrl;
  bool? isFinal;
  bool? isComplete;
  bool? isReceive;

  Achievement(
      {this.id,
      this.type,
      this.name,
      this.detail,
      this.criteria,
      this.grade,
      this.goal,
      this.prevGoal,
      this.progress,
      this.characterName,
      this.characterImgUrl,
      this.isFinal,
      this.isComplete,
      this.isReceive});

  Achievement.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["type"] is int) {
      type = json["type"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["detail"] is String) {
      detail = json["detail"];
    }
    if (json["criteria"] is String) {
      criteria = json["criteria"];
    }
    if (json["grade"] is int) {
      grade = json["grade"];
    }
    if (json["goal"] is double) {
      goal = json["goal"];
    }
    if (json["prevGoal"] is double) {
      prevGoal = json["prevGoal"];
    }
    if (json["progress"] is double) {
      progress = json["progress"];
    }
    if (json["characterName"] is String) {
      characterName = json["characterName"];
    }
    if (json["characterImgUrl"] is String) {
      characterImgUrl = json["characterImgUrl"];
    }
    if (json["isFinal"] is bool) {
      isFinal = json["isFinal"];
    }
    if (json["isComplete"] is bool) {
      isComplete = json["isComplete"];
    }
    if (json["isReceive"] is bool) {
      isReceive = json["isReceive"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["type"] = type;
    _data["name"] = name;
    _data["detail"] = detail;
    _data["criteria"] = criteria;
    _data["grade"] = grade;
    _data["goal"] = goal;
    _data["prevGoal"] = prevGoal;
    _data["progress"] = progress;
    _data["characterName"] = characterName;
    _data["characterImgUrl"] = characterImgUrl;
    _data["isFinal"] = isFinal;
    _data["isComplete"] = isComplete;
    _data["isReceive"] = isReceive;
    return _data;
  }
}

// 리워드 파라미터
class AchievementRewardRequest {
  final int id;
  final int typeId;
  final bool isFinal;
  final String characterName;
  final String characterImgUrl;

  AchievementRewardRequest({
    required this.id,
    required this.typeId,
    required this.isFinal,
    required this.characterName,
    required this.characterImgUrl,
  });
}
