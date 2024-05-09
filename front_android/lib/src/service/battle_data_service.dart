import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/stomp_repository.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

final battleDataServiceProvider = Provider.autoDispose((ref) {
  StompRepository stompRepository = ref.watch(stompInstanceProvider);
  return SocketService(stompRepository);
});

class SocketService with ChangeNotifier {
  StompRepository stompInstance;

  SocketService(this.stompInstance);

  late int roomId;
  List<Participant> participants = [];

  String mode = BattleModeHelper.matching;

  String getNicknameById(int memberId) => participants
      .firstWhere(
        (element) => element.memberId == memberId,
      )
      .nickname;

  List<BattleRecordOfParticipant> battleData = [];

  void setParticipants(List<Participant> newParticipants) {
    participants = newParticipants;
  }

  void updateBattleDataSortByDistance(List<BattleRecordOfParticipant> data) {
    battleData = data.toList()
      ..sort(((a, b) => b.distance.compareTo(a.distance)));
  }

  Future<void> matchingStart(void Function(bool canStart) startChanger) async {
    try {
      await apiInstance.patch('api/matchings');
    } catch (error) {
      rethrow;
    }

    // 매칭이 시작된 상태 아직 매칭이 되지는 않음 구독
    stompInstance.subScribe(
      destination:
          DestinationHelper.getStartMatching(UserService.instance.nickname),
      callback: (StompFrame data) {
        // 방의 id와 상대의 id
        print('stomp 서버 데이터 1번 $data');
        // 소켓 인스턴스에 방의 정보를 저장한 뒤 매칭 수락, 거절 화면으로 이동
        if (data.body != null) {
          var json = jsonDecode(data.body!);
          if (json["action"] == ActionHelper.matchingStartAction) {
            var battleData = MatchingRoomData.fromJson(json);
            roomId = battleData.matchingRoomId;
            try {
              participants = [
                Participant.fromJson(json),
                Participant(
                  memberId: -1,
                  nickname: UserService.instance.nickname,
                  characterImgUrl: UserService.instance.characterImgUrl,
                  isManager: false,
                  isReady: false,
                ),
              ];
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
  }

  void disconnect() {
    stompInstance.disconnect();
  }
}
