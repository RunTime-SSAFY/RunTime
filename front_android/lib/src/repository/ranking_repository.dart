import 'package:flutter/material.dart';
import 'package:front_android/src/model/ranking.dart';
import 'package:front_android/src/service/https_request_service.dart';

class RankingRepository {
  List<Ranking> rankings = [];
  Future<void> getRankingList() async {
    try {
      var response = await apiInstance.get(
        'api/rankings',
      );
      var rankingsJson = response.data['ranking'];
      rankings =
          (rankingsJson as List).map((e) => Ranking.fromJson(e)).toList();
      return;
    } catch (error) {
      debugPrint(error.toString());
      return;
    }
  }

  // 초기화
  void clearRankingList() {
    rankings = [];
  }
}
