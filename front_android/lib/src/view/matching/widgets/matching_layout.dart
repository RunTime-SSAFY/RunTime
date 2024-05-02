import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/theme/components/png_image.dart';

class MatchingLayoutView extends ConsumerWidget {
  const MatchingLayoutView({
    super.key,
    required this.button,
    this.middleWidget,
    this.hintMessage,
  });

  final Widget button;
  final Widget? middleWidget;
  final Widget? hintMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(matchingViewModelProvider);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background/battleBackground.png'),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: PngImage(
                  'matching/${viewModel.image}',
                  size: 150,
                ),
              ),
              SizedBox(
                height: 100,
                child: Text(
                  viewModel.mainMessage,
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
