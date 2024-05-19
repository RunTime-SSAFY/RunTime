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
