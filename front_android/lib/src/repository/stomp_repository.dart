import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

final stompInstanceProvider = Provider.autoDispose((ref) {
  var stompRepository = StompRepository()..init();
  ref.onDispose(() {
    print('연결 종료');
    stompRepository.disconnect();
  });
  return stompRepository;
});

class StompRepository with ChangeNotifier {
  late StompClient _client;

  StompRepository();

  void init() {
    debugPrint('생성요청: StompRepository ${dotenv.get('SOCKET_URL')}');
    _client = StompClient(
      config: StompConfig.sockJS(
        url: dotenv.get('SOCKET_URL'),
        stompConnectHeaders: {
          'Authorization': AuthService.instance.accessToken!,
          'Connection': 'upgrade'
        },
        webSocketConnectHeaders: {
          'Authorization': AuthService.instance.accessToken!,
        },
        onConnect: (p0) {
          debugPrint('웹 소켓 연결 성공');
        },
        onDebugMessage: (p0) {
          debugPrint('StompClient 내부 디버그 메세지${p0.toString()}');
        },
        onWebSocketError: (p0) {
          debugPrint('소켓 연결 에러 ${p0.toString()}');
        },
        onUnhandledMessage: (p0) {
          debugPrint('핸들러가 없는 이벤트${p0.toString()}');
        },
        onDisconnect: (p0) {
          debugPrint('웹 소켓 서버 연결 해제 완료');
        },
      ),
    )..activate();
  }

  void activate() {
    _client.activate();
  }

  bool get isConnected => _client.isActive;

  void subScribe({
    required String destination,
    required void Function(StompFrame) callback,
    Map<String, String>? headers,
  }) {
    _client.subscribe(
      headers: headers,
      destination: destination,
      callback: callback,
    );
  }

  void send({
    required String destination,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) {
    _client.send(
      destination: destination,
      body: jsonEncode(body),
      headers: headers,
    );
  }

  void disconnect() {
    _client.deactivate();
  }
}
