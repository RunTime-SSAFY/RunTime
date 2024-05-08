import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class TextInput extends ConsumerWidget {
  const TextInput({
    super.key,
    required this.controller,
    required this.textInputFormatter,
    this.onSubmit,
    this.onChanged,
    this.icon,
    this.title,
    this.textColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.backGroundColor,
    this.padding,
    this.keyboardType,
  });

  final TextEditingController controller;
  final void Function()? onSubmit;
  final List<TextInputFormatter> textInputFormatter;
  final void Function()? onChanged;
  final Widget? icon;
  final String? title;
  final Color? textColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? backGroundColor;
  final EdgeInsets? padding;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null)
            Text(
              title!,
              style: ref.typo.body2.copyWith(
                color: ref.color.inactive,
              ),
            ),
          TextField(
            onSubmitted: (value) {
              onSubmit?.call();
            },
            onChanged: (value) {
              onChanged?.call();
            },
            keyboardType: keyboardType ?? TextInputType.text,
            controller: controller,
            inputFormatters: textInputFormatter,
            cursorColor: textColor ?? ref.color.onBackground,
            style: ref.typo.subTitle1.copyWith(
              color: textColor ?? ref.color.onBackground,
            ),
            decoration: InputDecoration(
                filled: true,
                fillColor: backGroundColor ?? Colors.transparent,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: focusedBorderColor ?? ref.color.onBackground,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: enabledBorderColor ?? ref.color.accept,
                  ),
                ),
                suffixIcon: icon),
          ),
        ],
      ),
    );
  }
}
