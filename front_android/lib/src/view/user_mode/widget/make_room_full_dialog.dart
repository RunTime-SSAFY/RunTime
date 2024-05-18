import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/user_mode/user_mode_view_model.dart';
import 'package:front_android/src/view/user_mode/widget/number_button.dart';
import 'package:front_android/src/view/user_mode/widget/text_input.dart';
import 'package:front_android/src/view/user_mode/widget/toggle_button.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/image_background.dart';
import 'package:front_android/theme/components/keyboard_hiding.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/helper/text_input_format_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class MakeRoomFullDialog extends ConsumerWidget {
  const MakeRoomFullDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModeViewModel viewModel = ref.watch(userModeViewModelProvider);

    return KeyboardHide(
      child: BattleImageBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ref.color.onBackground,
                size: 30,
              ),
            ),
            centerTitle: true,
            title: Text(S.current.makingRoom,
                style: ref.typo.appBarMainTitle.copyWith(
                  color: ref.color.onBackground,
                )),
          ),
          body: Column(
            children: [
              const Spacer(flex: 1),
              TextInput(
                title: S.current.roomName,
                controller: viewModel.roomNameTextController,
                onSubmit: () {},
                textInputFormatter: [
                  TextInputFormatHelper.maximumLength(20),
                ],
              ),
              const SizedBox(height: 15),
              ToggleButton(
                isPublic: viewModel.password == null
                    ? true
                    : viewModel.password!.isEmpty,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      S.current.password,
                      style: ref.typo.headline4.copyWith(
                        color: ref.color.onBackground,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextInput(
                        controller: viewModel.passwordController,
                        onChanged: viewModel.onChangeText,
                        textInputFormatter: [
                          TextInputFormatHelper.englishNumber,
                          TextInputFormatHelper.maximumLength(20),
                        ]),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: NumberButton(
                        title: S.current.capacity,
                        number: viewModel.capacity.toDouble(),
                        changeNum: viewModel.setCapacity,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: NumberButton(
                        title: S.current.distance,
                        number: viewModel.distance,
                        changeNum: viewModel.setDistance,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Button(
                  onPressed: () async {
                    var room = await viewModel.makeRoom();
                    if (room != null) {
                      if (!context.mounted) return;
                      context.pushReplacement(
                        RoutePathHelper.waitingRoomWithId(room.roomId),
                        extra: {'isManager': true, 'roomData': room},
                      );
                    }
                  },
                  text: S.current.create,
                  backGroundColor: ref.color.accept,
                  fontColor: ref.color.onAccept,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
