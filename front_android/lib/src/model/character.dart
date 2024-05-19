class Character {
  int id;
  String detail;
  String imgUrl;
  String name;
  int achievementId;
  bool isCheck;
  bool unlockStatus;

  Character({
    required this.id,
    required this.detail,
    required this.imgUrl,
    required this.name,
    required this.achievementId,
    required this.isCheck,
    required this.unlockStatus,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      detail: json['detail'],
      id: json['id'],
      imgUrl: json['imgUrl'],
      name: json['name'],
      achievementId: json['achievementId'],
      isCheck: json['isCheck'],
      unlockStatus: json['unlockStatus'],
    );
  }
}

class CharacterData {
  int id;
  String achievementName;
  bool isHidden;
  String name;
  String detail;
  String imgUrl;
  bool isCheck;
  bool unlockStatus;
  bool isMain;

  CharacterData({
    required this.id,
    required this.achievementName,
    required this.isHidden,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.isCheck,
    required this.unlockStatus,
    required this.isMain,
  });

  factory CharacterData.fromJson(Map<String, dynamic> json) {
    return CharacterData(
      id: json['id'],
      achievementName: json['achievementName'],
      isHidden: json['isHidden'],
      name: json['name'],
      detail: json['detail'],
      imgUrl: json['imgUrl'],
      isCheck: json['isCheck'],
      unlockStatus: json['unlockStatus'],
      isMain: json['isMain'],
    );
  }
}
