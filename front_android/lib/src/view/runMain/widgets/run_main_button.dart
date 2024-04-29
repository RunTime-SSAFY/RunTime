import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/theme/components/png_image.dart';

class RunMainButton extends ConsumerWidget {
  const RunMainButton(
    this.modeName,
    this.modeRoute,
    this.color, {
    super.key,
  });

  final String modeName;
  final String modeRoute;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, modeRoute);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              modeName,
              style: ref.typo.headline2,
            ),
            PngImage(
              image: modeRoute,
              size: 60,
            ),
            Text(
              '→',
              style: ref.typo.headline1,
            )
          ],
        ),
      ),
    );
  }
}
