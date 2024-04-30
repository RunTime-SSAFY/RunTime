import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/lang_service.dart';
import 'package:front_android/theme/components/bottom_sheet/Tile.dart';
import 'package:front_android/theme/components/bottom_sheet/bottom_sheet_base.dart';
import 'package:front_android/util/helper/l10n_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class BottomSheetSetting extends ConsumerWidget {
  const BottomSheetSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locale = ref.watch(langServiceProvider).locale;
    var changeLang = ref.read(langServiceProvider.notifier).changeLang;
    void onLanguagePressed() {
      if (locale == IntlHelper.en) {
        changeLang(IntlHelper.ko);
      } else {
        changeLang(IntlHelper.en);
      }
    }

    return BottomSheetBase(
      child: Column(
        children: [
          Tile(
            icon: Icons.language,
            title: S.current.language,
            value: S.current.currentLanguage,
            onPressed: onLanguagePressed,
          ),
        ],
      ),
    );
  }
}
