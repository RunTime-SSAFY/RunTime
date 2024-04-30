import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_android/src/service/theme_service.dart';

class AppIcon extends ConsumerWidget {
  const AppIcon(
    this.icon, {
    this.color,
    this.size,
    super.key,
  });

  final String icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? ref.color.text,
        BlendMode.srcIn,
      ),
    );
  }
}
