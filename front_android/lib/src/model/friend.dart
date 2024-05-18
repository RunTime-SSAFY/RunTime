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

class FriendRequest {
  int id;
  String name;
  String characterImgUrl;
  String tierImgUrl;

  FriendRequest({
    required this.id,
    required this.name,
    required this.characterImgUrl,
    required this.tierImgUrl,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
        id: json['id'],
        name: json['name'],
        characterImgUrl: json['characterImgUrl'],
        tierImgUrl: json['tierImgUrl'],
      );
}
