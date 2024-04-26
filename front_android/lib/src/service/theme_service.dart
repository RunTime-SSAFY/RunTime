import 'package:flutter/material.dart';
import 'package:front_android/src/theme/foundation/app_theme.dart';
import 'package:front_android/src/theme/nomal_theme.dart';

class ThemeService with ChangeNotifier {
  ThemeService({
    AppTheme? theme,
  }) : theme = theme ?? NormalTheme();

  AppTheme theme;

  // 테마 변경

  // Material Theme 커스텀
  ThemeData get themeDate {
    return ThemeData(
      /// Scaffold
      scaffoldBackgroundColor: theme.color.surface,

      /// AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: theme.color.surface,
        elevation: 0,
        // Android, IOS 다르게 작동하여 false
        centerTitle: false,
        iconTheme: IconThemeData(
          color: theme.color.text,
        ),
        titleTextStyle: theme.typo.headline2.copyWith(
          color: theme.color.text,
        ),
      ),

      // BottomSheet - IOS의 모서리의 배경색이 적용안되는 문제 해결
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
