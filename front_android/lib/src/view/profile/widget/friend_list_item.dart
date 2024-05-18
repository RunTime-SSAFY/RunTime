import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/friend.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/profile/profile_view_model.dart';
import 'package:front_android/src/view/profile/widget/image_name_tier.dart';

class FriendListItem extends ConsumerWidget {
  const FriendListItem({super.key, required this.friend});

  final Friend friend;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileViewModel viewModel = ref.watch(profileProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        children: [
          ImageNameTier(
              characterImgUrl: friend.characterImgUrl,
              name: friend.name,
              tierImgUrl: friend.tierImgUrl),
          IconButton(
            onPressed: viewModel.deleteFriend,
            icon: Icon(
              Icons.close,
              color: ref.color.profileText,
            ),
          ),
        ],
      ),
    );
  }
}
