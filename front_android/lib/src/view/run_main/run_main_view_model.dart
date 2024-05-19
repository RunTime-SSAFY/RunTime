import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

final runMainProvider = ChangeNotifierProvider((ref) => RunMainViewModel());

class RunMainViewModel with ChangeNotifier {
  void noNickName(BuildContext context) {
    if (UserService.instance.nickname == '') {
      context.go(RoutePathHelper.profileEdit);
    }
  }

  void fetchingData(BuildContext context) async {
    try {
      await UserService.instance.getUserInfor();
      if (!context.mounted) return;
      noNickName(context);
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
