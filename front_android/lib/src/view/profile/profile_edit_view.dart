import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/profile/profile_view_model.dart';
import 'package:front_android/src/view/user_mode/widget/text_input.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/helper/text_input_format_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class ProfileEditView extends ConsumerWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProfileViewModel viewModel = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          color: ref.color.black,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          S.current.profileEdit,
          style: ref.typo.appBarSubTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "닉네임"
            Text(
              S.current.nickname,
              style: ref.typo.subTitle2.copyWith(
                color: ref.palette.gray600,
              ),
            ),
            TextInput(
              controller: viewModel.nicknameController,
              textInputFormatter: [
                TextInputFormatHelper.englishKoreanNumber,
                TextInputFormatHelper.maximumLength(12),
              ],
              textColor: ref.palette.gray700,
              enabledBorderColor: ref.palette.gray700,
              focusedBorderColor: ref.palette.gray500,
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            // 닉네임 규칙
            Text(
              S.current.nicknameRule,
              style: ref.typo.body1.copyWith(
                color: ref.palette.gray500,
              ),
            ),
            const SizedBox(height: 60),
            // "몸무게"
            Text(
              S.current.weight,
              style: ref.typo.subTitle2.copyWith(
                color: ref.palette.gray600,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextInput(
                    controller: viewModel.weightController,
                    textInputFormatter: [TextInputFormatHelper.onlyDouble],
                    textColor: ref.palette.gray700,
                    enabledBorderColor: ref.palette.gray700,
                    focusedBorderColor: ref.palette.gray500,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
                Text(
                  'kg',
                  style: ref.typo.appBarMainTitle.copyWith(
                    color: ref.palette.gray500,
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
                color: ref.palette.gray500,
              ),
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
