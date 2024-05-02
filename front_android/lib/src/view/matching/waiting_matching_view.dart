import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/src/view/matching/widgets/matching_layout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

enum StateType {
  start,
  matching,
  found,
  waiting;
}

// 주석: 대기열 큐에 들어감

class WaitingMatching extends ConsumerWidget {
  const WaitingMatching({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewModel = ref.watch(matchingViewModelProvider);

    viewModel.matchingState = MatchingState.matching;

    return MatchingLayoutView(
      button: Button(
        onPressed: () => viewModel.onPressCancelInBeforeMatching(context),
        text: S.current.cancel,
        backGroundColor: ref.color.deny,
        fontColor: ref.color.onDeny,
      ),
      middleWidget: Expanded(
          child: SvgIcon(
        'matching/waitingIcon',
        color: ref.color.onBackground,
        size: 100,
      )),
    );
  }
}