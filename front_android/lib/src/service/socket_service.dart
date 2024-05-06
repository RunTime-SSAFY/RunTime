import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketProvider = Provider.autoDispose((ref) {
  final socketRepository = SocketService();
  ref.onDispose(() {
    socketRepository.close();
  });
  return socketRepository;
});

class SocketService {
  SocketService() {
    init();
  }

  MatchingRoomData? roomData;

  final IO.Socket _socket = IO.io(dotenv.get('BASE_URL'));

  void init() {
    _socket.onConnect((_) => print('소켓 연결 완료'));
  }

  IO.Socket get streamController => _socket;

  void on(String event, dynamic Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void off(String event) {
    _socket.off(event);
  }

  void emit(String event, [dynamic data]) {
    _socket.emit(event, data);
  }

  void close() {
    _socket.close();
  }
}
