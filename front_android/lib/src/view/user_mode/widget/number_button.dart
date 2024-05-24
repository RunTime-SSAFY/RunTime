import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class NumberButton extends ConsumerWidget {
  const NumberButton({
    super.key,
    required this.title,
    required this.number,
    required this.changeNum,
  });

  final String title;
  final double number;
  final void Function(double num) changeNum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ref.typo.body2.copyWith(
            color: ref.palette.gray400,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: GestureDetector(
                onTapUp: (details) {
                  if (number > 1) {
                    changeNum(number - 1);
                  } else if (title == S.current.distance && number == 1) {
                    changeNum(0.1);
                  }
                },
                child: NumberButtonBox(
                  color: ref.color.userModeBackground,
                  child: Icon(
                    Icons.horizontal_rule_rounded,
                    color: ref.color.onBackground,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 10,
              child: NumberButtonBox(
                color: ref.color.battleMode2,
                child: Text(
                  '${number == 0.1 ? number : number.toStringAsFixed(0)}',
                  style: ref.typo.headline2.copyWith(
                    color: ref.color.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 10,
              child: GestureDetector(
                onTapUp: (details) {
                  if (title == S.current.distance && number == 0.1) {
                    changeNum(1);
                  } else if (number < 5) {
                    changeNum(number + 1);
                  }
                },
                child: NumberButtonBox(
                  color: ref.color.userModeBackground,
                  child: Icon(
                    Icons.add_rounded,
                    color: ref.color.onBackground,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              flex: 10,
              child: SizedBox(),
            ),
            const Spacer(flex: 1),
            Expanded(
              flex: 10,
              child: Center(
                child: Text(
                  title == '인원 수' ? '명' : 'km',
                  style: ref.typo.body2.copyWith(color: ref.palette.gray400),
                ),
              ),
            ),
            const Spacer(flex: 1),
            const Expanded(
              flex: 10,
              child: SizedBox(),
            )
          ],
        ),
      ],
    );
  }
}

class NumberButtonBox extends ConsumerWidget {
  const NumberButtonBox({
    super.key,
    required this.child,
    required this.color,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: child,
    );
  }
}
