import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/login/widgets/kakao_login_button.dart';
import 'package:front_android/theme/components/bottom_sheet/bottom_sheet_setting.dart';
import 'package:video_player/video_player.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/videos/login_background.mp4')
          ..initialize().then(
            (_) {
              setState(
                () {
                  _controller.setPlaybackSpeed(0.8);
                  _controller.play();
                  _controller.setLooping(true);
                },
              );
            },
          );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onPressSetting() {
      showModalBottomSheet(
        context: context,
        builder: (context) => const BottomSheetSetting(),
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            // 비디오 재생
            _controller.value.isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : Container(color: ref.color.black),

            // 비디오 위에 검은색 반투명 레이어
            SizedBox.expand(
              child: Container(
                color: ref.color.black.withOpacity(0.5),
              ),
            ),

            // 설정 버튼
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: onPressSetting,
                  icon: const Icon(Icons.settings),
                  color: ref.color.onBackground,
                ),
              ),
            ),

            // 로고 및 카카오 로그인 버튼
            Center(
              child: Column(
                children: [
                  const Spacer(
                    flex: 4,
                  ),
                  Image.asset(
                    "assets/images/logo/RUNTIME_LOGO_TEXT_WHITE.png",
                    width: 200,
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  KakaoLoginButton(ref.locale.toString()),
                  const Spacer(
                    flex: 4,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   decoration: const BoxDecoration(
    //     image: DecorationImage(
    //       fit: BoxFit.fitHeight,
    //       image: AssetImage('assets/images/background/loginBackground.png'),
    //     ),
    //   ),
    //   child: PopScope(
    //     canPop: false,
    //     child: Scaffold(
    //       backgroundColor: const Color(0x99000000),
    //       body: SafeArea(
    //         child: Column(
    //           children: [
    //             Align(
    //               alignment: Alignment.centerRight,
    //               child: IconButton(
    //                 onPressed: onPressSetting,
    //                 icon: const Icon(Icons.settings),
    //                 color: ref.color.onBackground,
    //               ),
    //             ),
    //             Expanded(
    //               child: Center(
    //                 child: Column(
    //                   children: [
    //                     const Spacer(
    //                       flex: 2,
    //                     ),
    //                     Image.asset("assets/images/mainCharacter.gif"),
    //                     const Spacer(
    //                       flex: 1,
    //                     ),
    //                     Text(
    //                       "Run Mate",
    //                       style: ref.typo.mainTitle.copyWith(
    //                         color: ref.color.onBackground,
    //                       ),
    //                     ),
    //                     const Spacer(
    //                       flex: 1,
    //                     ),
    //                     KakaoLoginButton(ref.locale.toString()),
    //                     const Spacer(
    //                       flex: 4,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
