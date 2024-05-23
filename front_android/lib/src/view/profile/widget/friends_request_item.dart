import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/friend.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/profile/profile_view_model.dart';
import 'package:front_android/src/view/profile/widget/image_name_tier.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class FriendRequestItem extends ConsumerWidget {
  const FriendRequestItem({
    super.key,
    required this.friendRequest,
  });

  final NotFriend friendRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileViewModel viewModel = ref.watch(profileProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          // 닉네임 및 티어
          ImageNameTier(
            characterImgUrl: friendRequest.characterImgUrl,
            name: friendRequest.name,
            tierImgUrl: friendRequest.tierImgUrl,
          ),
          // 수락 버튼
          Button(
            onPressed: () {
              viewModel.responseToFriendRequest(friendRequest.id, true);
            },
            text: S.current.accept,
            backGroundColor: ref.color.accept,
            fontColor: ref.color.onAccept,
            radius: 5,
            fontSize: 18,
            height: 38,
            width: 56,
          ),
          const SizedBox(width: 10),
          // 거절 버튼
          Button(
            onPressed: () {
              viewModel.responseToFriendRequest(friendRequest.id, false);
            },
            text: S.current.deny,
            backGroundColor: Colors.transparent,
            fontColor: ref.color.deny,
            radius: 5,
            fontSize: 18,
            height: 38,
            width: 56,
          ),
        ],
      ),
    );
  }
}
