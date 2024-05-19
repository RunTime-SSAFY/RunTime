class Ranking {
  String nickname;
  int tierScore;
  String tierName;
  String tierImage;

  Ranking({
    required this.nickname,
    required this.tierScore,
    required this.tierName,
    required this.tierImage,
  });
  factory Ranking.fromJson(Map<String, dynamic> json) {
    return Ranking(
      nickname: json['nickname'] ?? 'null',
      tierScore: json['tierScore'] ?? 0,
      tierName: json['tierName'] ?? 'null',
      tierImage: json['tierImage'] ?? 'null',
    );
  }
}
