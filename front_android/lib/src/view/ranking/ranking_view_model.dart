import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/ranking.dart';
import 'package:front_android/src/repository/ranking_repository.dart';

final rankingViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => RankingViewModel());

class RankingViewModel with ChangeNotifier {
  RankingRepository rankingRepository = RankingRepository();
  List<Ranking> get rankingList => rankingRepository.rankings;

  void getRankingList() async {
    await Future.wait(
      [
        rankingRepository.getRankingList(),
      ],
    );
    notifyListeners();
  }

  // 초기화
  void clearRankingList() {
    rankingRepository.clearRankingList();
    notifyListeners();
  }
}
