import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/repository/user_mode_room_repository.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

final waitingViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  battleData.stompInstance.activate();
  return WaitingViewModel(battleData);
});

class WaitingViewModel with ChangeNotifier {
  final BattleDataService _battleData;
  WaitingViewModel(this._battleData);

  bool _disposed = false;

  @override
  void notifyListeners() {
    if (_disposed) return;
    super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

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

  void getParticipants(
      int roomId, Map<String, dynamic> data, BuildContext context) async {
    _battleData.roomId = roomId;
    if (data['isManager']) {
      _battleData.participants = [
        Participant(
          nickname: UserService.instance.nickname,
          characterImgUrl: UserService.instance.characterImgUrl,
          isManager: true,
          isReady: true,
          distance: 0,
          lastDateTime: DateTime.now(),
        ),
      ];
      var room = data['roomData'] as UserModeRoom;
      _battleData.uuid = room.uuid;
      userModeRoomRepository.setRoomInfo(room);
    } else {
      var response =
          await userModeRoomRepository.enterRoom(_battleData.roomId, null);

      _battleData.participants = (response['data'] as List)
          .map(
            (element) => Participant.fromJson(element),
          )
          .toList();
      _battleData.uuid = response['uuid'];

      var room = data['roomData'] as UserModeRoom;
      userModeRoomRepository.setRoomInfo(room);
    }
    _battleData.stompInstance.subScribe(
      destination: DestinationHelper.getForSub('room', _battleData.uuid),
      callback: (p0) {
        var json = jsonDecode(p0.body!);
        switch (json['action']) {
          case 'member':
            _battleData.participants = (json['data'] as List)
                .map((element) => Participant.fromJson(element))
                .toList();
            notifyListeners();
            break;
          case 'start':
            context.go(RoutePathHelper.battle);
            break;
        }
      },
    );
    notifyListeners();
  }

  bool get canStart =>
      participants.every(
        (element) {
          return element.isReady || element.isManager;
        },
      ) &&
      participants.length > 1;

  Future<void> roomOut(BuildContext context) async {
    try {
      userModeRoomRepository.roomOut(_battleData.roomId);
      if (!context.mounted) return;
      context.pop();
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 404) {
        context.pop();
      }
      debugPrint(error.toString());
    }
  }

  Future<void> battleStart() async {
    try {
      apiInstance.patch('api/rooms/${_battleData.roomId}/start');
    } catch (error) {
      debugPrint('시작 실패 $error');
    }
  }

  Participant get myInfo => _battleData.participants.firstWhere(
      (element) => element.nickname == UserService.instance.nickname,
      orElse: () => Participant(
            nickname: '',
            characterImgUrl: '',
            isManager: false,
            isReady: false,
            distance: 0,
            lastDateTime: DateTime.now(),
          ));

  Future<void> onPressButton() async {
    if (myInfo.isManager) {
      try {
        apiInstance.patch('api/rooms/${_battleData.roomId}/start');
      } catch (error) {
        debugPrint(error.toString());
      }
    } else {
      try {
        apiInstance.patch('api/rooms/${_battleData.roomId}/ready');
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }
}
