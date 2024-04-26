import 'package:flutter/material.dart';
import 'package:front_android/src/theme/foundation/app_theme.dart';
import 'package:front_android/src/theme/res/typo.dart';

class NormalTheme implements AppTheme {
  @override
  ThemeName themeName = ThemeName.normal;

  @override
  AppColor color = const AppColor(
    accept: Color(0x004c51bf),
    deny: Color(0x00c53030),
    inactive: Color(0x00d9d9d9),
    neutral: Color(0x0038a169),
    onAccept: Color(0x00f8f8f8),
    onDeny: Color(0x00f8f8f8),
    onInactive: Color(0x00f8f8f8),
    onNeutral: Color(0x00f8f8f8),
    trace: Color(0x0048bb78),
    traceBackground: Color(0x00d9d9d9),
    userMode: Color(0x007f9cf5),
    practiceMode: Color(0x00ed8936),
    rankingButton: Color(0x00fc8181),
    battleMode1: Color(0x001a202c),
    battleMode2: Color(0x004a5568),
    list1Main: Color(0x005334b2),
    list2Main: Color(0x00344db6),
    list3Main: Color(0x002f855a),
    list4Main: Color(0x00b83280),
    list5Main: Color(0x00c53030),
    list1Sub: Color(0x009468f8),
    list2Sub: Color(0x00688cfd),
    list3Sub: Color(0x0068d391),
    list4Sub: Color(0x00f687b3),
    list5Sub: Color(0x00fc8181),
    achievementLevel: Color(0x00ecc94b),
    counterAchievementLevel: Color(0x00f8f8f8),
    surface: Color(0x00f8f8f8),
    text: Colors.black,
  );

  @override
  late AppTypo typo = AppTypo(typo: const Pretendard(), fontColor: color.white);
}
