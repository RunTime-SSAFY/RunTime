import 'package:front_android/util/lang/generated/l10n.dart';

interface class TierHelper {
  static String getTier(String tierName) {
    tierName = tierName.toLowerCase();
    if (tierName.startsWith('beginner')) {
      return S.current.beginner;
    } else if (tierName.startsWith('pro')) {
      return S.current.pro;
    } else if (tierName.startsWith('world')) {
      return S.current.worldClass;
    }
    return S.current.amateur;
  }
}
