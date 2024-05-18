import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/friend.dart';
import 'package:front_android/src/repository/friend_repository.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:go_router/go_router.dart';

final profileProvider =
    ChangeNotifierProvider.autoDispose((ref) => ProfileViewModel());

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

    var result = await UserService.instance
        .changeUserInfor(newNickname: nickname, newWeight: weight);

    if (result) {
      context.go(RoutePathHelper.runMain);
    }
  }

  FriendRepository friendRepository = FriendRepository();

  List<Friend> get friendList => friendRepository.friends;

  void getFriendList() async {
    await Future.wait([
      friendRepository.getFriendList(),
      friendRepository.getFriendRequest(),
    ]);

    notifyListeners();
  }

  Future<void> deleteFriend() async {}

  List<FriendRequest> get friendRequestList => friendRepository.friendRequest;

  Future<void> responseToFriendRequest(int requesterId, bool isAccept) async {
    var url = 'api/friends/$requesterId';
    try {
      if (isAccept) {
        apiInstance.patch(url);
      } else {
        apiInstance.delete(url);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
