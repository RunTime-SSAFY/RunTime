import 'package:flutter/foundation.dart';
import 'package:front_android/src/model/friend.dart';
import 'package:front_android/src/service/https_request_service.dart';

class FriendRepository {
  List<Friend> friends = [];

  List<NotFriend> friendRequest = [];

  bool hasNext = true;

  int? get lastId {
    if (friends.isEmpty) return null;
    return friends.last.id;
  }

  Future<void> getFriendList() async {
    if (!hasNext) return;
    try {
      var response = await apiInstance.get(
        'api/friends',
        queryParameters: {
          if (lastId != null) 'lastId': lastId,
          'size': 5,
        },
      );
      var newFriendList = [
        ...friends,
        ...(response.data['friendList'] as List<dynamic>)
            .map((e) => Friend.fromJson(e))
      ];
      friends = newFriendList;

      hasNext = response.data['hasNext'];
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> getFriendRequest() async {
    try {
      var response = await apiInstance.get('api/friends/requests');
      friendRequest = (response.data as List<dynamic>)
          .map((e) => NotFriend.fromJson(e))
          .toList();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
