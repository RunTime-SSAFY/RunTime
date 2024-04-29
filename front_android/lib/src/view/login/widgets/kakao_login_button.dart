import 'package:flutter/material.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton(
    this.locale, {
    super.key,
  });

  final String locale;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: S.current.kakaoLogin,
      child: GestureDetector(
        onTap: () {},
        child: PngImage(
          'kakaoLogin_$locale',
        ),
      ),
    );
  }
}
