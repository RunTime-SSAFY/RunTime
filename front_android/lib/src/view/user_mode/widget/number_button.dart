import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

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
            color: ref.color.inactive,
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 10,
              child: GestureDetector(
                onTapUp: (details) {
                  if (number > 0) changeNum(number - 1);
                },
                child: NumberButtonBox(
                  color: ref.color.userModeBackground,
                  child: Icon(
                    Icons.horizontal_rule,
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
                  number.toStringAsFixed(0),
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
                  if (number < 5) changeNum(number + 1);
                },
                child: NumberButtonBox(
                  color: ref.color.userModeBackground,
                  child: Icon(
                    Icons.add,
                    color: ref.color.onBackground,
                  ),
                ),
              ),
            )
          ],
        )
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
