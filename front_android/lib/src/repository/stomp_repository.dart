import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/auth_service.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

final stompInstanceProvider = Provider.autoDispose((ref) {
  var stompRepository = StompRepository();
  ref.onDispose(() {
    print('연결 종료');
    stompRepository.disconnect();
  });
  return stompRepository;
});

class StompRepository {
  late StompClient _client;

  StompRepository() {
    print('생성: StompRepository ${dotenv.get('SOCKET_URL')}');
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
          print('웹 소켓 연결 성공 ${p0.toString()}');
        },
        onDebugMessage: (p0) {
          print('StompClient 내부 디버그 메세지${p0.toString()}');
        },
        onWebSocketError: (p0) {
          print('소켓 연결 에러 ${p0.toString()}');
        },
        onUnhandledMessage: (p0) {
          print('핸들러가 없는 이벤트${p0.toString()}');
        },
        onDisconnect: (p0) {
          print('웹 소켓 서버 연결 해제 완료');
        },
      ),
    )..activate();
  }

  void connect() {
    _client.activate();
  }

  bool get isConnected => _client.isActive;

  void subScribe({
    required String destination,
    required void Function(StompFrame) callback,
  }) {
    _client.subscribe(
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
