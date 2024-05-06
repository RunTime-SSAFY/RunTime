import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front_android/src/service/socket_service.dart';

class SocketRepository {
  SocketRepository();

  late final BattleSocket? _socket;
  final String socketBaseUrl = dotenv.get('SOCKET_URL');

  int count = 0;

  // 매칭요청

  // 연결 해제
  void disconnect() async {
    _socket?.close();
  }

  void onDispose() {
    disconnect();
  }
}
