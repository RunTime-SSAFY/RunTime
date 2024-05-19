import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/run_main/run_main_view_model.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/theme/components/text_clip_horizontal.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class BattleModeButton extends ConsumerWidget {
  const BattleModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RunMainViewModel viewModel = ref.watch(runMainProvider);

    return GestureDetector(
      onTap: () => viewModel.onPress(context),
      child: AspectRatio(
        aspectRatio: 1.618,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                ref.color.battleMode1,
                ref.color.battleMode2,
              ],
            ),
          ),
          child: Stack(
            children: [
              // 티어 이미지
              Positioned(
                bottom: -154,
                left: -87,
                child: PngImage(
                  'tier/${viewModel.tierImage}',
                  size: MediaQuery.of(context).size.width,
                ),
              ),
              // 텍스트 박스
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 모드 이름
                    Row(children: [
                      Text(
                        S.current.battleMode,
                        style: ref.typo.headline1.copyWith(
                          color: ref.color.onBackground,
                        ),
                      ),
                    ]),

                    // 티어점수
                    Row(
                      children: [
                        const Spacer(),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              TextClipHorizontal(
                                child: Text(
                                  viewModel.tier,
                                  style: ref.typo.headline1.copyWith(
                                      color: ref.color.onBackground,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              TextClipHorizontal(
                                child: Text(
                                  '${viewModel.score}점',
                                  style: ref.typo.subTitle1.copyWith(
                                    color: ref.color.onBackground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // 입장 화살표
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          S.current.enter,
                          style: ref.typo.headline2.copyWith(
                            color: ref.color.onBackground,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SvgIcon(
                          'arrow_forward_rounded',
                          color: ref.color.onBackground,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
