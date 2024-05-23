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

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent) {
          viewModel.getFriends();
        }
        return false;
      },
      child: ListView.builder(
        shrinkWrap: true, // <==== limit height. 리스트뷰 크기 고정
        primary: false, // <====  disable scrolling. 리스트뷰 내부는 스크롤 안할거임
        itemCount: mergedList.length,
        itemBuilder: (context, index) {
          final item = mergedList[index];
          if (item is NotFriend) {
            // 친구 요청 목록 나타내기
            return FriendRequestItem(
              friendRequest: item,
            );
          } else if (item is Friend) {
            // 친구 목록 나타내기
            return FriendListItem(
              friend: item,
            );
          } else if (item == 'noRequest') {
            // 친구요청이 없습니다. 텍스트
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  S.current.friendRequest404,
                  style: ref.typo.subTitle1.copyWith(
                    color: ref.palette.gray400,
                  ),
                ),
              ),
            );
          } else if (item == 'request') {
            // 친구 요청 제목
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                S.current.friendRequest,
                style: ref.typo.headline1.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            );
          } else if (item == 'list') {
            // 친구목록 제목 및 친구 추가하기 버튼
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 친구 목록 제목
                  Text(
                    S.current.friendList,
                    style: ref.typo.headline1.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 친구 추가하기 버튼
                  GestureDetector(
                    onTapUp: (details) {
                      viewModel.showSearchModal(context);
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ref.palette.gray400,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.add_rounded,
                            color: ref.palette.gray400,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          S.current.friendAdd,
                          style: ref.typo.headline2.copyWith(
                            color: ref.palette.gray400,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            );
          }
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
