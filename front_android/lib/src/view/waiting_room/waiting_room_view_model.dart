import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/user_mode_room_repository.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:go_router/go_router.dart';

final waitingViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  return WaitingViewModel(battleData);
});

class WaitingViewModel with ChangeNotifier {
  final BattleDataService _battleData;
  WaitingViewModel(this._battleData);

  final userModeRoomRepository = UserModeRoomRepository();

  String get title => userModeRoomRepository.roomTitle;

  double get _distance => userModeRoomRepository.distance;
  String get distance => _distance.toKilometer();

  bool get isManager {
    try {
      return _battleData.participants
          .firstWhere(
              (element) => element.nickname == UserService.instance.nickname)
          .isManager;
    } catch (error) {
      return false;
    }
  }

  List<Participant> get participants => _battleData.participants;

  void getParticipants() async {
    _battleData.participants =
        await userModeRoomRepository.fetchingParticipants(_battleData.roomId);
    _battleData.stompInstance.subScribe(
      destination: DestinationHelper.getForSub('room', _battleData.uuid),
      callback: (p0) {
        var json = jsonDecode(p0.body!);
        if (json['action'] == 'member') {
          _battleData.participants =
              json['data'].map((element) => Participant.fromJson(element));
        }
      },
    );
    notifyListeners();
  }

  bool get canStart => !participants.every(
        (element) {
          return element.isReady || element.isManager;
        },
      );

  Future<void> roomOut(BuildContext context) async {
    try {
      await apiInstance.delete('api/rooms/${_battleData.roomId}/exit');
      if (!context.mounted) return;
      context.pop();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void fetchRoomInfor(int roomId) {
    _battleData.roomId = roomId;
    userModeRoomRepository.fetchingParticipants(roomId);
  }
}
