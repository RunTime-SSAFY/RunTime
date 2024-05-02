import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class IntlHelper {
  static const Locale ko = Locale('ko');
  static const Locale en = Locale('en');

  String get currentLang => Intl.getCurrentLocale();
}
