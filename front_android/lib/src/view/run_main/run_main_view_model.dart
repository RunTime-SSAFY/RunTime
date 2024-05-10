import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:go_router/go_router.dart';

final runMainProvider = ChangeNotifierProvider((ref) => RunMainViewModel());

class RunMainViewModel with ChangeNotifier {
  void noNickName(BuildContext context) {
    if (UserService.instance.nickname == '') {
      // Navigator.popAndPushNamed(context, RoutePath.profile);
      context.push('/nickname');
    }
  }
}
