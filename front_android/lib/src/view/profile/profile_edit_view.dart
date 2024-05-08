import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/profile/profile_view_model.dart';
import 'package:front_android/src/view/user_mode/widget/text_input.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/helper/text_input_format_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class ProfileEditView extends ConsumerWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileViewModel viewModel = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.current.profileEdit,
          style: ref.typo.appBarMainTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.nickname,
                  style: ref.typo.bigRegular.copyWith(
                    color: ref.color.inactive,
                  ),
                ),
                TextInput(
                  controller: viewModel.nicknameController,
                  textInputFormatter: [
                    TextInputFormatHelper.englishKoreanNumber,
                    TextInputFormatHelper.maximumLength(12),
                  ],
                  textColor: ref.color.text,
                  enabledBorderColor: ref.color.text,
                  focusedBorderColor: ref.color.text,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                Text(
                  S.current.nicknameRule,
                  style: ref.typo.body1.copyWith(
                    color: ref.color.inactive,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.weight,
                  style: ref.typo.bigRegular.copyWith(
                    color: ref.color.inactive,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextInput(
                        controller: viewModel.weightController,
                        textInputFormatter: [TextInputFormatHelper.onlyDouble],
                        textColor: ref.color.text,
                        enabledBorderColor: ref.color.text,
                        focusedBorderColor: ref.color.text,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                    Text(
                      'kg',
                      style: ref.typo.appBarMainTitle.copyWith(
                        color: ref.color.inactive,
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
                Text(
                  S.current.weightRule,
                  style: ref.typo.body1.copyWith(
                    color: ref.color.inactive,
                  ),
                )
              ],
            ),
            const Spacer(),
            Button(
              onPressed: () => viewModel.send(context),
              text: S.current.editProfileDone,
              backGroundColor: ref.color.accept,
              fontColor: ref.color.onAccept,
            )
          ],
        ),
      ),
    );
  }
}
