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
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

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
              Icons.clear_rounded,
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
                  size: 180,
                ),
                const Spacer(flex: 1),

                // 연습모드 설명 텍스트
                WrappedKoreanText(
                  S.current.practiceExplanation,
                  style: ref.typo.bigRegular.copyWith(
                    fontSize: 28,
                    color: ref.color.onBackground,
                    // wordSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 8),
                const SummaryBox(),
                const Spacer(flex: 2),
                Button(
                  onPressed: () async {
                    var result = await viewModel.startPractice();
                    print('========================================$result');
                    if (!result) return;
                    if (!context.mounted) return;
                    context.go(RoutePathHelper.battle);
                  },
                  text: S.current.practiceStart,
                  backGroundColor: ref.color.accept,
                  fontColor: ref.color.onAccept,
                ),
                const SizedBox(height: 10),
                Text(
                  S.current.practiceAdditionalExplanation,
                  style: ref.typo.body1.copyWith(
                    fontSize: 12,
                    color: ref.palette.gray400,
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
