import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/src/view/matching/widgets/lodinag_animation.dart';
import 'package:front_android/src/view/matching/widgets/matching_layout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class WaitingMatching extends ConsumerWidget {
  const WaitingMatching({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MatchingViewModel viewModel = ref.watch(matchingViewModelProvider);

    if (viewModel.isMatched) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        viewModel.isMatched = false;
        context.pushReplacement(RoutePathHelper.matched);
      });
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        viewModel.onPressCancelDuringMatching(context);
      },
      child: MatchingLayoutView(
        image: 'matching',
        mainMessage: S.current.matching,
        button: Button(
          onPressed: () {
            viewModel.onPressCancelDuringMatching(context);
          },
          text: S.current.cancel,
          backGroundColor: ref.color.deny,
          fontColor: ref.color.onDeny,
        ),
        middleWidget: const LoadingAnimatedBars(),
      ),
    );
  }
}
