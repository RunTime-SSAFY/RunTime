import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/image_background.dart';
import 'package:front_android/theme/components/png_image.dart';

class MatchingLayoutView extends ConsumerWidget {
  const MatchingLayoutView({
    super.key,
    required this.button,
    required this.image,
    required this.mainMessage,
    this.middleWidget,
    this.hintMessage,
  });

  final Widget button;
  final Widget? middleWidget;
  final Widget? hintMessage;
  final String image;
  final String mainMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BattleImageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: PngImage(
                  'matching/$image',
                  size: 150,
                ),
              ),
              SizedBox(
                height: 100,
                child: Text(
                  mainMessage,
                  textAlign: TextAlign.center,
                  style: ref.typo.headline1.copyWith(
                    color: ref.color.onBackground,
                  ),
                ),
              ),
              middleWidget != null
                  ? Expanded(child: middleWidget!)
                  : const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: button,
                ),
              ),
              if (hintMessage != null) hintMessage!,
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
