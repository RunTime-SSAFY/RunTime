import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/theme/basic_theme.dart';
import 'package:front_android/theme/foundation/app_theme.dart';

final themeServiceProvider = ChangeNotifierProvider((ref) => ThemeService());

class ThemeService with ChangeNotifier {
  AppTheme theme;

  ThemeService({
    AppTheme? theme,
  }) : theme = theme ?? BasicTheme();

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

extension ThemeServiceExt on WidgetRef {
  ThemeService get themeService => watch(themeServiceProvider);
  AppTheme get theme => themeService.theme;
  AppColor get color => theme.color;
  AppTypo get typo => theme.typo;
  Palette get palette => theme.palette;
}
