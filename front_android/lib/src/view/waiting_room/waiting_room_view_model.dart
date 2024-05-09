import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';

final waitingViewModelProvider =
    ChangeNotifierProvider((ref) => WaitingViewModel());

class WaitingViewModel with ChangeNotifier {
  final String title = '제목';

  final double _distance = 3;
  String get distance => '${_distance.toString()}km';

  List<Participant> participants = [
    Participant(
      characterImgUrl: 'https://randomfox.ca/images/50.jpg',
      isManager: true,
      isReady: false,
      memberId: 1,
      nickname: '몇글자까지',
    ),
    Participant(
      characterImgUrl: 'https://randomfox.ca/images/50.jpg',
      isManager: false,
      isReady: true,
      memberId: 2,
      nickname: '글자수가많아졌다',
    ),
    Participant(
      characterImgUrl: 'https://randomfox.ca/images/50.jpg',
      isManager: false,
      isReady: false,
      memberId: 4,
      nickname: 'f31f31',
    )
  ];

  bool get canStart => !participants.every((element) {
        return element.isReady || element.isManager;
      });
}
