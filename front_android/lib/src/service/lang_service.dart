import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/util/helper/l10n_helper.dart';

final langServiceProvider = ChangeNotifierProvider((ref) => LangService());

class LangService with ChangeNotifier {
  /// 현재 언어
  Locale locale;

  LangService({
    Locale? locale,
  }) : locale = locale ?? IntlHelper.ko;

  /// 언어 변경
  void changeLang(Locale targetLang) {
    locale = targetLang;
    notifyListeners();
  }
}

extension LangServiceExt on WidgetRef {
  LangService get _langService => watch(langServiceProvider);
  Locale get locale => _langService.locale;
  set changeLang(Locale targetLang) => _langService.changeLang(targetLang);
}
