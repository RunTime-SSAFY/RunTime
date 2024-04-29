import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/login/widgets/kakao_login_button.dart';
import 'package:front_android/theme/components/png_image.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage('assets/images/loginBackground.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0x99000000),
        body: Center(
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
                style: ref.typo.mainTitle,
              ),
              const Spacer(
                flex: 1,
              ),
              const KakaoLoginButton(),
              const Spacer(
                flex: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
