import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

enum StateType {
  start,
  matching,
  found,
  waiting;
}

// 주석: 대기열 큐에 들어감

class Matching extends ConsumerWidget {
  const Matching({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressButton() {
      Navigator.pop(context);
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
                'matching/matching',
                size: 150,
              ),
              Text(
                S.current.matching,
                textAlign: TextAlign.center,
                style: ref.typo.headline1.copyWith(
                  color: ref.color.onBackground,
                ),
              ),
              Expanded(
                child: SvgIcon(
                  'matching/waitingIcon',
                  color: ref.color.onBackground,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                  onPressed: onPressButton,
                  text: S.current.cancel,
                  backGroundColor: ref.color.deny,
                  fontColor: ref.color.onDeny,
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
