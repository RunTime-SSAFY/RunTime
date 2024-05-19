import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/friend.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/profile/profile_view_model.dart';
import 'package:front_android/src/view/profile/widget/friend_list_item.dart';
import 'package:front_android/src/view/profile/widget/friends_request_item.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class FriendListBuilder extends ConsumerWidget {
  const FriendListBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileViewModel viewModel = ref.watch(profileProvider);

    List<dynamic> mergedList = [
      'request',
      if (viewModel.friendRequestList.isEmpty) 'noRequest',
      ...viewModel.friendRequestList,
      'list',
      ...viewModel.friendList,
    ];

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent) {
            viewModel.getFriends();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: mergedList.length,
          itemBuilder: (context, index) {
            final item = mergedList[index];
            if (item is NotFriend) {
              return FriendRequestItem(
                friendRequest: item,
              );
            } else if (item is Friend) {
              return FriendListItem(
                friend: item,
              );
            } else if (item == 'noRequest') {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    S.current.friendRequest404,
                    style: ref.typo.subTitle1.copyWith(
                      color: ref.color.profileText,
                    ),
                  ),
                ),
              );
            } else if (item == 'request') {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S.current.friendRequest,
                  style: ref.typo.headline1,
                ),
              );
            } else if (item == 'list') {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.friendList,
                      style: ref.typo.headline1,
                    ),
                    GestureDetector(
                      onTapUp: (details) {
                        viewModel.showSearchModal(context);
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ref.color.profileText,
                                width: 2.5,
                              ),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.add,
                              color: ref.color.profileText,
                              size: 30,
                            ),
                          ),
                          Text(
                            S.current.friendAdd,
                            style: ref.typo.headline2.copyWith(
                              color: ref.color.profileText,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox(height: 10);
          },
        ),
      ),
    );
  }
}
