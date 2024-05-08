import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/user_mode/user_mode_view_model.dart';
import 'package:front_android/src/view/user_mode/widget/room_empty.dart';
import 'package:front_android/src/view/user_mode/widget/text_input.dart';
import 'package:front_android/src/view/user_mode/widget/user_mode_room.dart';
import 'package:front_android/theme/components/circular_indicator.dart';
import 'package:front_android/theme/components/image_background.dart';
import 'package:front_android/util/helper/text_input_format_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class UserModeSearchView extends ConsumerWidget {
  const UserModeSearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModeViewModel viewModel = ref.watch(userModeViewModelProvider);

    return Stack(
      children: [
        BattleImageBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ref.color.onBackground,
                  size: 30,
                ),
              ),
              centerTitle: true,
              title: Text(
                S.current.findRoom,
                style: ref.typo.appBarMainTitle.copyWith(
                  color: ref.color.onBackground,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                TextInput(
                  title: S.current.EnterSearchTerm,
                  controller: viewModel.textController,
                  onSubmit: viewModel.searchRoomList,
                  textInputFormatter: [
                    TextInputFormatHelper.englishKoreanNumber,
                    TextInputFormatHelper.maximumLength(20),
                  ],
                  icon: IconButton(
                    icon: Icon(Icons.search, color: ref.color.onBackground),
                    onPressed: viewModel.searchRoomList,
                  ),
                ),
                viewModel.userModeRoomList.isEmpty
                    ? const RoomEmpty()
                    : Expanded(
                        child: UserModeRoomList(
                          userModeRoomList: viewModel.userModeSearchedList,
                          getRoomList: viewModel.getRoomList,
                        ),
                      ),
              ],
            ),
          ),
        ),
        CircularIndicator(isLoading: viewModel.isLoading),
      ],
    );
  }
}
