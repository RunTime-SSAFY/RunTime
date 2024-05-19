class Friend {
  int id;
  String name;
  String characterImgUrl;
  int tierScore;
  String tierImgUrl;

  Friend({
    required this.id,
    required this.name,
    required this.characterImgUrl,
    required this.tierScore,
    required this.tierImgUrl,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json['id'],
        name: json['name'],
        characterImgUrl: json['characterImgUrl'],
        tierScore: json['tierScore'],
        tierImgUrl: json['tierImgUrl'],
      );
}

class NotFriend {
  int id;
  String name;
  String characterImgUrl;
  String tierImgUrl;
  bool alreadyRequest;

  NotFriend({
    required this.id,
    required this.name,
    required this.characterImgUrl,
    required this.tierImgUrl,
    required this.alreadyRequest,
  });

  factory NotFriend.fromJson(Map<String, dynamic> json) => NotFriend(
        id: json['id'],
        name: json['name'],
        characterImgUrl: json['characterImgUrl'],
        tierImgUrl: json['tierImgUrl'],
        alreadyRequest: json['alreadyRequest'],
      );
}
