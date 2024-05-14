import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/user_mode_room_repository.dart';
import 'package:front_android/src/service/battle_data_service.dart';

final waitingViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  return WaitingViewModel(battleData);
});

class WaitingViewModel with ChangeNotifier {
  final BattleDataService _battleData;
  WaitingViewModel(this._battleData);

  final userModeRoomRepository = UserModeRoomRepository();

  final String title = '제목';

  final double _distance = 3;
  String get distance => '${_distance.toString()}km';

  List<Participant> participants = [];

  bool get canStart => !participants.every((element) {
        return element.isReady || element.isManager;
      });
}
