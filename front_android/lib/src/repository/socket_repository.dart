import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/model/participants.dart';

final socketProvider = Provider.autoDispose((ref) {
  final socketRepository = SocketRepository();
  return socketRepository;
});

class SocketRepository {
  MatchingData? matchingData;

  int distance = 3;

  List<Participants> participants = [];
}
