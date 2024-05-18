import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:go_router/go_router.dart';

class RunMainButton extends ConsumerWidget {
  const RunMainButton({
    required this.modeName,
    required this.modeRoute,
    required this.cardColor1,
    required this.cardColor2,
    super.key,
  });

  final String modeName;
  final String modeRoute;
  final Color cardColor1;
  final Color cardColor2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressed() {
      context.push(modeRoute);
    }

    return GestureDetector(
      onTap: onPressed,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // 그라데이션
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [cardColor1, cardColor2],
            ),
            // 그림자
            boxShadow: [
              BoxShadow(
                color: ref.color.black.withOpacity(0.25),
                offset: const Offset(1, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              // 아이콘
              Positioned.fill(
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    Flexible(
                      flex: 3,
                      child: PngImage(
                        modeRoute.substring(1, modeRoute.length),
                      ),
                      // child: SvgPicture.asset(
                      //   'assets/icons/${modeRoute.substring(1, modeRoute.length)}.svg',
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),

              // 카드 내용 텍스트
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  // padding: EdgeInsets.all(
                  //     MediaQuery.of(context).size.height > 700 ? 20 : 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 모드 이름
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          modeName,
                          style: ref.typo.headline2.copyWith(
                            color: ref.color.onBackground,
                          ),
                        ),
                      ),
                      // 화살표
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SvgIcon(
                          'arrow_forward_rounded',
                          color: ref.color.onBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
