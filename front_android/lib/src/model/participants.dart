class Participants {
  Participants({
    required this.nickname,
    required this.characterImgUrl,
    required this.isManager,
    required this.isReady,
  });
  final String nickname, characterImgUrl;
  final bool isManager, isReady;

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
        nickname: json['nickname'],
        characterImgUrl: json['characterImgUrl'] ?? '',
        isManager: json['isManager'] ?? false,
        isReady: json['isReady'] ?? true,
      );
}
