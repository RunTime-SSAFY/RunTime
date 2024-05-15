import 'package:flutter/material.dart';
import 'package:front_android/src/service/kakao_service.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton(
    this.locale, {
    super.key,
  });

  final String locale;

  @override
  Widget build(BuildContext context) {
    void onPress() async {
      if (!context.mounted) return;
      try {
        await KakaoService.kakaoLogin();
        if (!context.mounted) return;
        // Navigator.popAndPushNamed(context, RoutePath.runMain);
        context.go(RoutePathHelper.runMain);
      } catch (error) {
        debugPrint(error.toString());
      }
    }

    return Semantics(
      button: true,
      label: S.current.kakaoLogin,
      child: GestureDetector(
        onTap: onPress,
        child: PngImage(
          'kakaoLogin_$locale',
          // 화면 전체 크기에서 양쪽 20씩 뺸 크기
          // width: MediaQuery.of(context).size.width - 40,
        ),
      ),
    );
  }
}
