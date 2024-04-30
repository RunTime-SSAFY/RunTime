import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/countdown_progress_bar.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class FoundMatching extends ConsumerWidget {
  const FoundMatching({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressButton(bool button) {
      if (button) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/battleBackground.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const PngImage(
                'matching/foundMatching',
                size: 150,
              ),
              Text(
                S.current.foundMatching,
                textAlign: TextAlign.center,
                style: ref.typo.headline1.copyWith(
                  color: ref.color.onBackground,
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CountdownProgressBar(
                  handleTimeOver: () {},
                  seconds: 5,
                  valueColor: ref.color.accept,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Button(
                        onPressed: () {
                          onPressButton(false);
                        },
                        text: S.current.deny,
                        backGroundColor: ref.color.deny,
                        fontColor: ref.color.onDeny,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Button(
                        onPressed: () {
                          onPressButton(true);
                        },
                        text: S.current.accept,
                        backGroundColor: ref.color.accept,
                        fontColor: ref.color.onAccept,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                S.current.foundMatchingHint,
                style: ref.typo.subTitle4.copyWith(
                  color: ref.color.inactive,
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
