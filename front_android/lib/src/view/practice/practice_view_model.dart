import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/util/helper/extension.dart';

final practiceViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  return PracticeViewModel(battleData);
});

class PracticeViewModel with ChangeNotifier {
  final BattleDataService _battleData;

  PracticeViewModel(this._battleData);

  String distance = 3000.0.toKilometer();
  DateTime date = DateTime.now();
  String get pace => 8.toString();
  String get calorie => '${100.toString()}kcal';
  String get runningTime => const Duration(seconds: 1000).toHhMmSs();

  void startPractice() async {
    try {
      var response = await apiInstance.post('api/practice');

      assert(response.data.isNotEmpty, '응답이 비어있습니다.');
      var data = jsonDecode(response.data);

      _battleData.uuid = data['uuid'];
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
