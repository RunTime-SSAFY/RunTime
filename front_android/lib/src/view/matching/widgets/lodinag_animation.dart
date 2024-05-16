import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class LoadingAnimatedBars extends ConsumerStatefulWidget {
  const LoadingAnimatedBars({super.key});

  @override
  ConsumerState<LoadingAnimatedBars> createState() =>
      _LoadingAnimatedBarsState();
}

class _LoadingAnimatedBarsState extends ConsumerState<LoadingAnimatedBars>
    with TickerProviderStateMixin {
  final int numberOfBars = 4;
  List<AnimationController> controllers = [];
  List<Animation<double>> animations = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < numberOfBars; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      );

      // 각 애니메이션 컨트롤러에 대해 0.2초씩 지연 시작
      Future.delayed(Duration(milliseconds: i * 350), () {
        controller.repeat(reverse: true);
      });

      final animation = Tween<double>(begin: 10, end: 80).animate(controller);
      controllers.add(controller);
      animations.add(animation);
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(animations);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(numberOfBars * 2 - 1, (index) {
        if (index % 2 == 1) {
          // 짝수 인덱스에 간격을 위한 SizedBox를 추가
          return const SizedBox(width: 5);
        } else {
          // 홀수 인덱스에 각 바를 추가
          int barIndex = index ~/ 2; // 실제 바 인덱스 계산
          return AnimatedBuilder(
            animation: animations[barIndex],
            builder: (_, child) {
              return Container(
                width: 10,
                height: animations[barIndex].value,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ref.color.onBackground,
                ),
              );
            },
          );
        }
      }),
    );
  }
}
