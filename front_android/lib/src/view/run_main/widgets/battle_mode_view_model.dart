import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/helper/tier_helper.dart';
import 'package:go_router/go_router.dart';

final battleModeProvider =
    ChangeNotifierProvider((ref) => BattleModeViewModel());

class BattleModeViewModel with ChangeNotifier {
  late String tierImage = UserService.instance.tierName;

  late String tier = TierHelper.getTier(UserService.instance.tierName);

  late final int _score = UserService.instance.tierScore;
  String get score => _score.toString();

  // final int _percent = 13;
  // String get percent => _percent.toString();

  void onPress(BuildContext context) {
    context.push(RoutePathHelper.beforeMatching);
  }
}
