import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/route_path.dart';

final profileProvider = ChangeNotifierProvider((ref) => ProfileViewModel());

class ProfileViewModel with ChangeNotifier {
  TextEditingController nicknameController =
      TextEditingController(text: UserService.instance.nickname);
  String get nickname => nicknameController.text;

  TextEditingController weightController =
      TextEditingController(text: UserService.instance.weight.toString());
  double get weight => double.parse(weightController.text);

  void send(BuildContext context) async {
    if (nickname.length < 4) {
      return;
    }
    print('입력 $weight');

    var result = await UserService.instance
        .changeUserInfor(newNickname: nickname, newWeight: weight);

    if (result) {
      Navigator.pushNamed(context, RoutePath.runMain);
    }
  }
}
