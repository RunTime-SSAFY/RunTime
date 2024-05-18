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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          ImageNameTier(
            characterImgUrl: friendRequest.characterImgUrl,
            name: friendRequest.name,
            tierImgUrl: friendRequest.tierImgUrl,
          ),
          Button(
            onPressed: () {
              viewModel.responseToFriendRequest(friendRequest.id, true);
            },
            text: S.current.accept,
            backGroundColor: ref.color.accept,
            fontColor: ref.color.onAccept,
            width: 60,
          ),
          const SizedBox(width: 10),
          Button(
            onPressed: () {
              viewModel.responseToFriendRequest(friendRequest.id, false);
            },
            text: S.current.deny,
            backGroundColor: Colors.transparent,
            fontColor: ref.color.deny,
            width: 60,
          ),
        ],
      ),
    );
  }
}
