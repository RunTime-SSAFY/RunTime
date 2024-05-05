import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/user_mode_room.dart';
import 'package:front_android/src/repository/user_mode_room_repository.dart';

final userModeViewModelProvider =
    ChangeNotifierProvider((ref) => UserModeViewModel());

class UserModeViewModel with ChangeNotifier {
  List<UserModeRoom> userModeRoomList = [];

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
    userModeRoomList = results[0];

    _isLoading = false;
    notifyListeners();
  }
}
