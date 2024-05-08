import 'package:flutter/material.dart';
import 'package:front_android/theme/res/typo.dart';

part 'app_color.dart';
part 'app_typo.dart';
part 'palette.dart';

enum ThemeName {
  normal,
  // highContrast,
}

interface class AppTheme {
  late final ThemeName themeName;
  late final AppColor color;
  late final Palette palette;
  late final AppTypo typo;
}
