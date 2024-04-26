import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class Button extends ConsumerStatefulWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backGroundColor,
    required this.fontColor,
    this.width,
    bool? isInactive,
  }) : isInactive = isInactive ?? false;

  final void Function() onPressed;
  final String text;
  final Color backGroundColor;
  final Color fontColor;
  final double? width;
  final bool isInactive;

  @override
  ConsumerState<Button> createState() => _ButtonState();
}

class _ButtonState extends ConsumerState<Button> {
  // 눌러져있는지 시각적으로 확인을 하기 위한 변수
  bool isPressed = false;

  // 버튼을 누르면 isPressed 상태가 바뀜
  void onPressed(bool newIsPressed) {
    if (isPressed == newIsPressed) return;
    setState(() {
      isPressed = newIsPressed;
    });
  }

  bool get isInactive => isPressed || widget.isInactive;

  Color get backgroundColor =>
      isInactive ? ref.color.inactive : widget.backGroundColor;

  Color get color => widget.fontColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 버튼을 누르는 동작에 isPressed를 true로 변경
      onTapDown: (details) {
        onPressed(true);
      },

      // 버튼을 눌렀다가 놓았을 때 버튼 자체가 active 상태라면 위젯의 onPressed 실행
      onTapUp: (details) {
        onPressed(false);
        if (!widget.isInactive) {
          widget.onPressed();
        }
      },

      // 버튼 취소 동작에서 isPressed를 false로 바꾸기
      onTapCancel: () => onPressed(false),
      child: AnimatedContainer(
        height: 48,
        duration: const Duration(
          microseconds: 250,
        ),
        width: widget.width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: ref.typo.headline2.copyWith(
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
