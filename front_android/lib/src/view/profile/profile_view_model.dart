import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/friend.dart';
import 'package:front_android/src/repository/friend_repository.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/src/view/profile/widget/search_user_dialog.dart';
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

    if (result && context.mounted) {
      context.go(RoutePathHelper.runMain);
    }
  }

  // 친구
  FriendRepository friendRepository = FriendRepository();

  // 친구 목록
  List<Friend> get friendList => friendRepository.friends;

  void getFriends() {
    friendRepository.getFriendList();
  }

  void getFriendList() async {
    await Future.wait([
      friendRepository.getFriendList(),
      friendRepository.getFriendRequest(),
    ]);
    notifyListeners();
  }

  Future<void> deleteFriend(int friendId) async {
    try {
      apiInstance.delete('api/friends/$friendId');
    } catch (error) {
      debugPrint(error.toString());
    }
    friendRepository.friends.removeWhere(
      (element) => element.id == friendId,
    );
    notifyListeners();
  }

  // 친구 요청 받은 목록
  List<NotFriend> get friendRequestList => friendRepository.friendRequest;

  Future<void> responseToFriendRequest(int requesterId, bool isAccept) async {
    var url = 'api/friends/$requesterId';
    try {
      if (isAccept) {
        await apiInstance.patch(url);
        friendRepository.hasNext = true;
      } else {
        await apiInstance.delete(url);
        friendRepository.friendRequest
            .removeWhere((element) => element.id == requesterId);
      }
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      notifyListeners();
    }
  }

  // 검색
  void showSearchModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const SearchUserDialog();
      },
    );
  }

  TextEditingController textController = TextEditingController();

  List<NotFriend> searchResult = [];

  void searchFriend() async {
    if (textController.text.isEmpty) return;
    try {
      var response = await apiInstance.get(
        'api/friends/others',
        queryParameters: {
          'searchWord': textController.text,
          'size': 5,
        },
      );
      searchResult = (response.data['friendList'] as List)
          .map((e) => NotFriend.fromJson(e))
          .toList();
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void requestFriend(int id) {
    try {
      apiInstance.post('api/friends/$id');
    } catch (error) {
      debugPrint(error.toString());
    }
    searchResult.firstWhere((element) => element.id == id).alreadyRequest =
        true;
    notifyListeners();
  }
}
