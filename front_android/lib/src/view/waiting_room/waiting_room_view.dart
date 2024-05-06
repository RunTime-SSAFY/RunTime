import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/waiting_room/waiting_room_view_model.dart';
import 'package:front_android/src/view/waiting_room/widget/participants_grid.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/image_background.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class WaitingRoomArguments {
  WaitingRoomArguments({required this.roomId});

  final int roomId;
}

class WaitingRoom extends ConsumerWidget {
  const WaitingRoom({
    required this.roomId,
    super.key,
  });

  final int roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WaitingViewModel viewModel = ref.watch(waitingViewModelProvider);

    return BattleImageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
            S.current.waitingRoom,
            style: ref.typo.appBarMainTitle.copyWith(
              color: ref.color.onBackground,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.title,
                style: ref.typo.bigRegular.copyWith(
                  color: ref.color.onBackground,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                viewModel.distance,
                style: ref.typo.headline1.copyWith(
                  color: ref.color.onBackground,
                ),
              ),
              ParticipantsCartGrid(
                participants: viewModel.participants,
              ),
              Button(
                onPressed: () {},
                text: S.current.gameStart,
                backGroundColor: ref.color.accept,
                fontColor: ref.color.onAccept,
                isInactive: viewModel.canStart,
              )
            ],
          ),
        ),
      ),
    );
  }
}
