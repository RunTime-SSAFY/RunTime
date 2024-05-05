import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/repository/user_mode_room_repository.dart';
import 'package:front_android/util/route_path.dart';

final userModeViewModelProvider =
    ChangeNotifierProvider((ref) => UserModeViewModel());

class UserModeViewModel with ChangeNotifier {
  List<UserModeRoom> _userModeRoomList = [];

  List<String> tagList = const ['전체', '공개방', '1km', '3km', '5km'];
  Map<String, double> distanceMap = const {'1km': 1, '3km': 3, '5km': 5};
  String tagNow = '전체';

  void changeTag(String tag) {
    assert(tagList.contains(tag));
    tagNow = tag;
    notifyListeners();
  }

  List<UserModeRoom> get userModeRoomList {
    if (tagNow == '전체') {
      return _userModeRoomList;
    } else if (tagNow != "공개방") {
      return _userModeRoomList
          .where((element) => element.distance == distanceMap[tagNow])
          .toList();
    } else {
      return _userModeRoomList;
    }
  }

  final userModeRoomRepository = UserModeRoomRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getRoomList() async {
    _isLoading = true;
    notifyListeners();

    final results = await Future.wait([
      userModeRoomRepository.getUserModeRoomList(),
      Future.delayed(const Duration(milliseconds: 500)),
    ]);
    _userModeRoomList = results[0];

    _isLoading = false;
    notifyListeners();
  }

  void moveToSearch(BuildContext context) {
    Navigator.pushNamed(context, RoutePath.userModeSearch);
  }

  TextEditingController textController = TextEditingController();
  String get searchWord => textController.text.trim();

  List<UserModeRoom> userModeSearchedList = [];

  Future<void> searchRoomList() async {
    _isLoading = true;
    notifyListeners();

    final results = await Future.wait([
      userModeRoomRepository.getUserModeRoomList(searchWord: searchWord),
      Future.delayed(const Duration(milliseconds: 500)),
    ]);
    userModeSearchedList = results[0];

    _isLoading = false;
    notifyListeners();
  }
}
