import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/countdown_progress_bar.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class FoundMatching extends ConsumerStatefulWidget {
  const FoundMatching({super.key});

  @override
  ConsumerState<FoundMatching> createState() => _FoundMatchingState();
}

class _FoundMatchingState extends ConsumerState<FoundMatching> {
  bool isAccepted = false;

  void onPressButton(bool button) {
    if (button) {
      // Accept
      setState(() {
        isAccepted = true;
      });
    } else {
      // Deny
    }
  }

  @override
  Widget build(BuildContext context) {
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
              AnimatedSwitcher(
                duration: const Duration(microseconds: 500),
                child: PngImage(
                  'matching/${isAccepted ? 'waitingResponse' : 'foundMatching'}',
                  size: 150,
                ),
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
                  handleTimeOver: () => onPressButton(false),
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
                      child: AnimatedSwitcher(
                        duration: const Duration(microseconds: 500),
                        child: Button(
                          onPressed: () => onPressButton(false),
                          text: S.current.deny,
                          backGroundColor: ref.color.deny,
                          fontColor: ref.color.onDeny,
                          isInactive: isAccepted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(microseconds: 500),
                        child: Button(
                          onPressed: () => onPressButton(true),
                          text: S.current.accept,
                          backGroundColor: ref.color.accept,
                          fontColor: ref.color.onAccept,
                          isInactive: isAccepted,
                        ),
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
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
