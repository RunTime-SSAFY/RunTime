import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/run_main/widgets/battle_mode_view_model.dart';
import 'package:front_android/theme/components/text_clip_horizontal.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:geolocator/geolocator.dart';

class BattleModeButton extends ConsumerWidget {
  const BattleModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BattleModeViewModel viewModel = ref.watch(battleModeProvider);

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
                bottom: -50,
                left: 10,
                child: PngImage(
                  'tier/${viewModel.tierImage}',
                  size: MediaQuery.of(context).size.width * 0.5,
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
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: ref.color.onBackground,
                          weight: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: ClipRect(
              //           child: Container(
              //             // decoration: BoxDecoration(
              //             //   borderRadius: BorderRadius.circular(20),
              //             //   gradient: LinearGradient(
              //             //     begin: Alignment.centerLeft,
              //             //     end: Alignment.centerRight,
              //             //     colors: [
              //             //       ref.color.battleMode1,
              //             //       ref.color.battleMode2,
              //             //     ],
              //             //   ),
              //             // ),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   S.current.battleMode,
              //                   style: ref.typo.headline1.copyWith(
              //                     color: ref.color.onBackground,
              //                   ),
              //                 ),
              //                 Row(
              //                   children: [
              //                     // SizedBox(
              //                     //   height: 150,
              //                     //   child: Transform.scale(
              //                     //     scale: 1.4,
              //                     //     child: Transform.translate(
              //                     //       offset: const Offset(0, 25),
              //                     //       child: PngImage(
              //                     //         'tier/${viewModel.tierImage}',
              //                     //         size: 200,
              //                     //       ),
              //                     //     ),
              //                     //   ),
              //                     // ),
              //                     const Spacer(),
              //                     Column(
              //                       crossAxisAlignment: CrossAxisAlignment.end,
              //                       children: [
              //                         Padding(
              //                           padding:
              //                               const EdgeInsets.only(right: 40),
              //                           child: Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.center,
              //                             children: [
              //                               Text(
              //                                 viewModel.tier,
              //                                 style:
              //                                     ref.typo.headline2.copyWith(
              //                                   color: ref.color.onBackground,
              //                                 ),
              //                               ),
              //                               Text(
              //                                 viewModel.score,
              //                                 style:
              //                                     ref.typo.subTitle2.copyWith(
              //                                   color: ref.color.onBackground,
              //                                 ),
              //                               ),
              //                               const SizedBox(height: 15),
              //                               // Text(
              //                               //   '상위 ${viewModel.percent} %',
              //                               //   style: ref.typo.body2.copyWith(
              //                               //     color: ref.color.lightText,
              //                               //   ),
              //                               // )
              //                             ],
              //                           ),
              //                         ),
              //                         Text(
              //                           '${S.current.enter} →',
              //                           style: ref.typo.headline1.copyWith(
              //                             color: ref.color.onBackground,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
