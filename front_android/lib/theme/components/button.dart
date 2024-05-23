import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Button extends ConsumerStatefulWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backGroundColor,
    required this.fontColor,
    this.radius,
    this.height,
    this.width,
    bool? isInactive,
    this.fontSize,
  }) : isInactive = isInactive ?? false;

  final void Function() onPressed;
  final String text;
  final Color backGroundColor;
  final Color fontColor;
  final double? radius;
  BorderRadius? get borderRadius => radius != null
      ? BorderRadius.circular(radius!)
      : BorderRadius.circular(10);
  final double? height;
  final double? width;
  final bool isInactive;
  final double? fontSize;

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
      isInactive ? ref.palette.gray200 : widget.backGroundColor;

  Color get color => isInactive ? ref.palette.gray400 : widget.fontColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        onPressed(true);
      },
      onTapUp: (details) {
        onPressed(false);
        if (!widget.isInactive) {
          widget.onPressed();
        }
      },
      onTapCancel: () => onPressed(false),
      child: Semantics(
        button: true,
        label: S.current.semanticsButton,
        hint: widget.text,
        child: AnimatedContainer(
          height: widget.height ?? 48,
          duration: const Duration(
            milliseconds: 500,
          ),
          width: widget.width,
          // padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: widget.fontSize == null
                  ? ref.typo.headline2.copyWith(
                      color: color,
                    )
                  : ref.typo.headline2.copyWith(
                      fontSize: widget.fontSize!,
                      color: color,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
