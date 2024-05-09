import 'package:flutter/services.dart';

interface class TextInputFormatHelper {
  static final onlyKorean = FilteringTextInputFormatter.allow(RegExp(r'[ㄱ-힣]'));
  // 한글만 입력
  static LengthLimitingTextInputFormatter maximumLength(int length) {
    // 최대 글자 수
    return LengthLimitingTextInputFormatter(length);
  }

  static final englishKoreanNumber =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Zㄱ-힣0-9]'));

  static final englishNumber =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));

  static final onEnglish =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));

  static final onlyDouble =
      FilteringTextInputFormatter.allow(RegExp(r'^\d{1,3}(\.\d{0,2})?'));

  static FilteringTextInputFormatter withRegExp(String regExp) {
    return FilteringTextInputFormatter.allow(RegExp('r$regExp'));
  }
}
