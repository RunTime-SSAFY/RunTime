import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/png_image.dart';

class RunMainButton extends ConsumerWidget {
  const RunMainButton({
    required this.modeName,
    required this.modeRoute,
    required this.color,
    super.key,
  });

  final String modeName;
  final String modeRoute;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressed() {
      Navigator.pushNamed(context, modeRoute);
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.height > 700 ? 20 : 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    modeName,
                    style: ref.typo.headline2.copyWith(
                      color: ref.color.onBackground,
                    ),
                  ),
                ],
              ),
              PngImage(
                modeRoute,
                size: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '→',
                    style: ref.typo.headline1.copyWith(
                      color: ref.color.onBackground,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
