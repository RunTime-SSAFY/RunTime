import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/theme/components/png_image.dart';
import 'package:front_android/util/route_path.dart';

class BattleModeButton extends ConsumerWidget {
  const BattleModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(
          context,
          RoutePath.BattleMatching,
        ),
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      ref.color.battleMode1,
                      ref.color.battleMode2,
                    ],
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '대결모드',
                    style: ref.typo.headline1,
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          const PngImage(
                            image: 'pro_1',
                            size: 150,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Text(
                                  '등급',
                                  style: ref.typo.headline2,
                                ),
                                Text(
                                  '점수',
                                  style: ref.typo.subTitle2,
                                ),
                                Text(
                                  '상위 %',
                                  style: ref.typo.body2.copyWith(
                                    color: ref.color.lightText,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                const Placeholder(
                                  fallbackWidth: 100,
                                  fallbackHeight: 100,
                                ),
                                Text(
                                  '닉네임',
                                  style: ref.typo.headline3,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '입장 →',
                            style: ref.typo.headline1,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
