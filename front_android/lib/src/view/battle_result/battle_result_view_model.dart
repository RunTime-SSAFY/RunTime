import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/theme/components/png_image.dart';

final battleResultProvider = ChangeNotifierProvider((ref) => null);

class BattleViewModel with ChangeNotifier {
  final bool result = true;

  final int point = 30;
  final PngImage character = const PngImage('mainCharacter');
  final double distance = 1;
  final int pace = 630;
  final int calory = 155;

  final Duration time = const Duration(minutes: 6, seconds: 30);
}
