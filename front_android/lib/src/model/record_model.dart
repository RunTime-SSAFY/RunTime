class RecordModel {
  final int id;
  final int duration;
  final String gameMode;
  final int ranking;
  final double distance;

  RecordModel({
    required this.id,
    required this.duration,
    required this.gameMode,
    required this.ranking,
    required this.distance,
  });

  factory RecordModel.fromJson(Map<String, dynamic> json) => RecordModel(
        id: json['id'] as int,
        duration: json['duration'] as int,
        gameMode: json['gameMode'] as String,
        ranking: json['ranking'] as int,
        distance: json['distance'] as double,
      );
}
