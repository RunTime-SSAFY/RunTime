import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/src/view/matching/widgets/matching_layout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class StartMatchingView extends ConsumerWidget {
  const StartMatchingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MatchingViewModel viewModel = ref.watch(matchingViewModelProvider);

    return MatchingLayoutView(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: ref.color.onBackground,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      image: 'beforeMatching',
      mainMessage: S.current.beforeMatching,
      button: Button(
        onPressed: () => viewModel.onMatchingStart(context),
        text: S.current.beforeMatchingButton,
        backGroundColor: ref.color.accept,
        fontColor: ref.color.onAccept,
      ),
    );
  }
}
