import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/battle_data_service.dart';

final practiceViewModel = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  return PracticeViewModel(battleData);
});

class PracticeViewModel with ChangeNotifier {
  final _battleData;

  PracticeViewModel(this._battleData);
}
