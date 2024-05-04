import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class SocketRepository {
  SocketRepository() {
    dotenv.get('SOCKET_URL');
  }
  late final Socket _socket;
  late final String socketBaseUrl;

  int count = 0;

  // 매칭요청
  void randomMatchingStart() async {
    _socket = await Socket.connect(socketBaseUrl, 80);
    _socket.listen((event) {
      var stringData = String.fromCharCodes(event);
    });
  }

  void disconnect() async {
    _socket.destroy();
  }

  void onDispose() {
    // disconnect();
  }
}
