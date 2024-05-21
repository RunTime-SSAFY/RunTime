import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:front_android/util/helper/extension.dart';

final practiceViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  battleData.mode = BattleModeHelper.practiceMode;
  return PracticeViewModel(battleData);
});

class PracticeViewModel with ChangeNotifier {
  final BattleDataService _battleData;

  PracticeViewModel(this._battleData);

  String distance = 3000.0.toKilometer();
  DateTime date = DateTime.now();
  String get pace => 650.toString();
  String get calorie => '${128}kcal';
  String get runningTime => "16분 43초";

  Future<bool> startPractice() async {
    try {
      var response = await apiInstance.post('api/practice');

      assert(response.data.isNotEmpty, '응답이 비어있습니다.');
      _battleData.roomId = 0;
      _battleData.uuid = response.data['uuid'];
      return true;
    } catch (error) {
      debugPrint(error.toString());
      return false;
    }
  }
}
