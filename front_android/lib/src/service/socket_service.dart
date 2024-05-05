import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/socket_repository.dart';

final socketProvider = Provider.autoDispose((ref) {
  final socketRepository = SocketRepository();
  ref.onDispose(() {
    socketRepository.onDispose();
  });
  return socketRepository;
});

class BattleSocketStreamHandler {
  BattleSocketStreamHandler() {
    startListening();
  }

  final StreamController _controller = StreamController();

  StreamController get streamController => _controller;

  void addStreamData(BattleSocketData data) {
    _controller.add(data);
  }

  void startListening() {
    _controller.stream.listen((data) {
      // 스트림으로부터 받은 데이터를 처리
      print('보낼 데이터: $data');
    });
  }

  void onDispose() {
    _controller.close();
  }
}
