import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/login/widgets/kakao_login_button.dart';
import 'package:front_android/theme/components/bottom_sheet/bottom_sheet_setting.dart';
import 'package:front_android/theme/components/png_image.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressSetting() {
      showModalBottomSheet(
        context: context,
        builder: (context) => const BottomSheetSetting(),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/images/background/loginBackground.png'),
        ),
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: const Color(0x99000000),
          body: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: onPressSetting,
                    icon: const Icon(Icons.settings),
                    color: ref.color.onBackground,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        const PngImage("mainCharacter"),
                        const Spacer(
                          flex: 1,
                        ),
                        Text(
                          "Run Mate",
                          style: ref.typo.mainTitle.copyWith(
                            color: ref.color.onBackground,
                          ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
