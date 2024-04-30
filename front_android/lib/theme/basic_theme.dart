import 'package:flutter/material.dart';
import 'package:front_android/theme/foundation/app_theme.dart';
import 'package:front_android/theme/res/typo.dart';

class BasicTheme implements AppTheme {
  @override
  ThemeName themeName = ThemeName.normal;

  @override
  AppColor color = const AppColor(
    accept: Color(0xFF4c51bf),
    deny: Color(0xFFc53030),
    inactive: Color(0xFFa9a9a9),
    neutral: Color(0xFF38a169),
    onAccept: Color(0xFFf8f8f8),
    onDeny: Color(0xFFf8f8f8),
    onInactive: Color(0xFFf8f8f8),
    onNeutral: Color(0xFFf8f8f8),
    trace: Color(0xFF48bb78),
    traceBackground: Color(0xFFd9d9d9),
    userMode: Color(0xFF7f9cf5),
    practiceMode: Color(0xFFed8936),
    rankingButton: Color(0xFFfc8181),
    battleMode1: Color(0xFF1a202c),
    battleMode2: Color(0xFF4a5568),
    list1Main: Color(0xFF5334b2),
    list2Main: Color(0xFF344db6),
    list3Main: Color(0xFF2f855a),
    list4Main: Color(0xFFb83280),
    list5Main: Color(0xFFc53030),
    list1Sub: Color(0xFF9468f8),
    list2Sub: Color(0xFF688cfd),
    list3Sub: Color(0xFF68d391),
    list4Sub: Color(0xFFf687b3),
    list5Sub: Color(0xFFfc8181),
    onBackground: Color(0xFFf8f8f8),
    achievementLevel: Color(0xFFecc94b),
    counterAchievementLevel: Color(0xFFf8f8f8),
    surface: Color(0xFFf8f8f8),
    text: Colors.black,
    lightText: Color(0xFFCFCFCF),
  );

  @override
  late AppTypo typo = AppTypo(
    typo: const Pretendard(),
    fontColor: color.text,
  );
}
