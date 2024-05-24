import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/waiting_room/waiting_room_view_model.dart';
import 'package:front_android/src/view/waiting_room/widget/participants_grid.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/image_background.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class WaitingRoomView {
  WaitingRoomView({required this.roomId});

  final int roomId;
}

class WaitingRoom extends ConsumerStatefulWidget {
  const WaitingRoom({
    required this.roomId,
    required this.data,
    super.key,
  });

  final int roomId;
  final Map<String, dynamic> data;

  @override
  ConsumerState<WaitingRoom> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends ConsumerState<WaitingRoom> {
  late WaitingViewModel viewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getParticipants(widget.roomId, widget.data, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(waitingViewModelProvider);

    return BattleImageBackground(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          try {
            viewModel.roomOut(context);
          } catch (error) {
            debugPrint(error.toString());
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                viewModel.roomOut(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ref.color.onBackground,
              ),
            ),
            centerTitle: true,
            title: Text(
              S.current.waitingRoom,
              style: ref.typo.appBarSubTitle.copyWith(
                color: ref.color.onBackground,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 방제목
                Text(
                  viewModel.title,
                  style: ref.typo.bigRegular.copyWith(
                    color: ref.color.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),

                // 거리
                Text(
                  viewModel.distance,
                  style: ref.typo.headline1.copyWith(
                    color: ref.color.onBackground,
                  ),
                ),
                const SizedBox(height: 20),

                ParticipantsCartGrid(
                  participants: viewModel.participants,
                ),
                Button(
                  onPressed: viewModel.onPressButton,
                  text: viewModel.isManager
                      ? S.current.gameStart
                      : viewModel.myInfo.isReady
                          ? S.current.ready
                          : S.current.getReady,
                  backGroundColor: ref.color.accept,
                  fontColor: ref.color.onAccept,
                  isInactive: viewModel.myInfo.isManager
                      ? !viewModel.canStart
                      : viewModel.myInfo.isReady,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
