import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/stomp_repository.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

final battleDataServiceProvider = Provider.autoDispose((ref) {
  StompRepository stompRepository = ref.watch(stompInstanceProvider);
  return BattleDataService(stompRepository);
});

class BattleDataService with ChangeNotifier {
  StompRepository stompInstance;

  BattleDataService(this.stompInstance);

  late int roomId;

  List<Participant> participants = [];

  late String _uuid;
  String get uuid => _uuid;

  String mode = BattleModeHelper.matching;

  void setParticipants(List<Participant> newParticipants) {
    participants = newParticipants;
  }

  List<Participant> getBattleDataSortByDistance() {
    return participants.toList()
      ..sort(((a, b) => b.distance.compareTo(a.distance)));
  }

  void changeParticipantsDistance(Participant newParticipantsData) {
    participants.removeWhere(
        (element) => element.nickname == newParticipantsData.nickname);
    participants.add(newParticipantsData);
  }

  bool canStart = false;

  void subReady() {
    stompInstance.subScribe(
      destination: DestinationHelper.getMatchingReady(uuid),
      callback: (p0) {
        var json = jsonDecode(p0.body!);
        if (json['action'] == ActionHelper.battleStartAction) {
          canStart = true;
        } else if (json['action'] == ActionHelper.battleRealTimeAction) {
          var data = json['data'];
          var target = participants
              .firstWhere((element) => element.nickname == data['nickname']);
          var time = DateTime.parse(data['currentTime']);
          if (time.isAfter(target.lastDateTime)) {
            target.distance = data['distance'];
            target.lastDateTime = DateTime.parse(data['currentTime']);
          }
        }
      },
    );
  }

  Future<void> matchingStart(void Function(bool canStart) startChanger) async {
    // 매칭이 시작된 상태 아직 매칭이 되지는 않음 구독
    stompInstance.subScribe(
      destination:
          DestinationHelper.getStartMatching(UserService.instance.nickname),
      callback: (StompFrame data) {
        // 방의 id와 상대의 id
        print('stomp 서버 데이터 1번 ${data.body})}');
        // 소켓 인스턴스에 방의 정보를 저장한 뒤 매칭 수락, 거절 화면으로 이동
        if (data.body != null) {
          var json = jsonDecode(data.body!);
          if (json["action"] == ActionHelper.matchingStartAction) {
            var battleData = MatchingRoomData.fromJson(json['data']);
            roomId = battleData.matchingRoomId;
            _uuid = battleData.uuid;
            try {
              participants = [
                Participant.fromJson(json['data']),
                Participant(
                  nickname: UserService.instance.nickname,
                  characterImgUrl: UserService.instance.characterImgUrl,
                  isManager: false,
                  isReady: false,
                  distance: 0,
                  lastDateTime: DateTime.now(),
                ),
              ];
              startChanger(false);
            } catch (error) {
              print('잘못된 참가자 정보\n$error');
              rethrow;
            }
          } else if (json['action'] == ActionHelper.battleStartAction) {
            startChanger(json['data'] == true);
          }
        } else {
          participants = [];
          throw Error.safeToString('오류 발생');
        }
      },
    );

    try {
      await apiInstance.patch('api/matchings');
    } catch (error) {
      rethrow;
    }
  }

  void disconnect() {
    stompInstance.disconnect();
  }
}
