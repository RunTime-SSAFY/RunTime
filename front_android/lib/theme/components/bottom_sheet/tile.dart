import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class Tile extends ConsumerWidget {
  const Tile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String value;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      // 패딩 영역에 터치해도 동작
      behavior: HitTestBehavior.translucent,
      // deferToChild: 자식 중 하나가 적중 시 이벤트 수신(투명한 대상 제외)
      // translucent: 반투명한 대상 & 시각적으로 뒤에 있는 대상 포함
      // opaque: 시각적으로 뒤에 있는 대상은 이벤트 수신 불가능
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(icon),
            ),
            const Spacer(),

            // Title
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: ref.typo.headline4,
                ),
              ),
            ),
            const Spacer(),

            Expanded(
              child: Row(
                children: [
                  Text(
                    value,
                    style: ref.typo.subTitle4,
                  ),
                  const Spacer(),
                  const Icon(Icons.change_circle_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
