import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/practice/practice_view_model.dart';
import 'package:front_android/src/view/practice/widget/summary_box.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/image_background.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

class Practice extends ConsumerWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PracticeViewModel viewModel = ref.watch(practiceViewModelProvider);

    return BattleImageBackground(
      child: Scaffold(
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
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const PngImage(
                  'matching/practiceMode',
                  size: 200,
                ),
                Text(
                  S.current.practiceExplanation,
                  style: ref.typo.headline1.copyWith(
                    color: ref.color.onBackground,
                  ),
                ),
                const Spacer(flex: 5),
                const SummaryBox(),
                const Spacer(flex: 2),
                Button(
                  onPressed: () {
                    viewModel.startPractice();
                    context.go(RoutePathHelper.battle);
                  },
                  text: S.current.practiceStart,
                  backGroundColor: ref.color.accept,
                  fontColor: ref.color.onAccept,
                ),
                const SizedBox(height: 15),
                Text(
                  S.current.practiceAdditionalExplanation,
                  style: ref.typo.body1.copyWith(
                    color: ref.color.inactive,
                  ),
                ),
                const Spacer(flex: 7)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
