import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/socket_repository.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

final socketProvider = Provider.autoDispose((ref) {
  final socketRepository = SocketRepository();
  ref.onDispose(() {
    socketRepository.onDispose();
  });
  return socketRepository;
});

class BattleSocket {
  BattleSocket() {
    init();
  }

  final IO.Socket _socket = IO.io(dotenv.get('BASE_URL'));

  void init() {
    _socket.onConnect((_) => print('소켓 연결 완료'));
  }

  IO.Socket get streamController => _socket;

  void emitBattleData(BattleSocketData data) {
    _socket.emit('battleData', data);
  }

  void close() {
    _socket.close();
  }
}
