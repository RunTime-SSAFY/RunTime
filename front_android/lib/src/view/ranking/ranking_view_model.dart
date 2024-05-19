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

  // String get tiers {
  //   if (rankingList.) {
  //     return tierScore.result == 1 ? S.current.win : S.current.lose;
  //   } else {
  //     switch (_battleData.result) {
  //       case 1:
  //         return '1st';
  //       case 2:
  //         return '2nd';
  //       case 3:
  //         return '3rd';
  //       default:
  //         return '${_battleData.result}th';
  //     }
  //   }
  // }
}
