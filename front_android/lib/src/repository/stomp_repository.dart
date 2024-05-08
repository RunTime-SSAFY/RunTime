import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

final stompInstanceProvider = Provider.autoDispose((ref) => StompRepository());

class StompRepository {
  late StompClient _client;

  StompRepository() {
    _client = StompClient(
      config: StompConfig(
        url: dotenv.get('WEBSOCKET_URL'),
        onConnect: (StompFrame stompFrame) {
          print('웹 소켓 서버 연결 완료');
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
    print('웹 소켓 서버 연결 해제 완료');
  }
}
