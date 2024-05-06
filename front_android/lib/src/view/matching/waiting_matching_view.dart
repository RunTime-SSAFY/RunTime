import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/src/view/matching/widgets/matching_layout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class WaitingMatching extends ConsumerWidget {
  const WaitingMatching({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MatchingViewModel viewModel = ref.watch(matchingViewModelProvider);

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
        middleWidget: SvgIcon(
          'matching/waitingIcon',
          color: ref.color.onBackground,
          size: 100,
        ),
      ),
    );
  }
}
