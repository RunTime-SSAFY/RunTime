import 'package:flutter/material.dart';
import 'package:front_android/util/helper/l10n_helper.dart';

class LangService with ChangeNotifier {
  LangService({
    Locale? locale,
  }) : locale = locale ?? IntlHelper.ko;

  /// 현재 언어
  Locale locale;

  /// 언어 변경
  void changeLang(Locale targetLang) {
    locale = targetLang;
    notifyListeners();
  }
}
