import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/profile/profile_view_model.dart';
import 'package:front_android/src/view/profile/widget/image_name_tier.dart';
import 'package:front_android/src/view/user_mode/widget/text_input.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/helper/text_input_format_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class SearchUserDialog extends ConsumerWidget {
  const SearchUserDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileViewModel viewModel = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.friendAdd,
          style: ref.typo.appBarMainTitle,
        ),
      ),
      body: Column(
        children: [
          TextInput(
            textColor: ref.color.text,
            enabledBorderColor: ref.color.accept,
            focusedBorderColor: ref.color.profileText,
            title: S.current.EnterSearchTerm,
            controller: viewModel.textController,
            onSubmit: viewModel.searchFriend,
            textInputFormatter: [
              TextInputFormatHelper.englishKoreanNumber,
              TextInputFormatHelper.maximumLength(20),
            ],
            icon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: viewModel.searchFriend,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.searchResult.length,
              itemBuilder: (context, index) {
                var item = viewModel.searchResult[index];
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      ImageNameTier(
                        characterImgUrl: item.characterImgUrl,
                        name: item.name,
                        tierImgUrl: item.tierImgUrl,
                      ),
                      Button(
                        onPressed: () => viewModel.requestFriend(item.id),
                        text: S.current.friendRequest,
                        backGroundColor: ref.color.accept,
                        fontColor: ref.color.onAccept,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
