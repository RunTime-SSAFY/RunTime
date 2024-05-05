import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/user_mode/user_mode_view_model.dart';
import 'package:front_android/src/view/user_mode/widget/add_room_button.dart';
import 'package:front_android/src/view/user_mode/widget/room_empty.dart';
import 'package:front_android/src/view/user_mode/widget/tag_button.dart';
import 'package:front_android/src/view/user_mode/widget/user_mode_room.dart';
import 'package:front_android/theme/components/image_background.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class UserModeView extends ConsumerStatefulWidget {
  const UserModeView({super.key});

  @override
  ConsumerState<UserModeView> createState() => _UserModeViewState();
}

class _UserModeViewState extends ConsumerState<UserModeView> {
  late UserModeViewModel viewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getRoomList();
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(userModeViewModelProvider);

    return BattleImageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
              color: ref.color.onBackground,
              size: 40,
            ),
          ),
          centerTitle: true,
          title: Text(
            S.current.userMode,
            style: ref.typo.appBarMainTitle.copyWith(
              color: ref.color.onBackground,
            ),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: ref.color.onBackground,
                size: 40,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const TagButtonList(),
            viewModel.userModeRoomList.isEmpty
                ? const RoomEmpty()
                : const Expanded(child: UserModeRoomList()),
          ],
        ),
        floatingActionButton: const MakeRoomButton(),
      ),
    );
  }
}
