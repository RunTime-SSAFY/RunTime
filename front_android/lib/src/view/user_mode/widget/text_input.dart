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
  });

  final TextEditingController controller;
  final void Function()? onSubmit;
  final List<TextInputFormatter> textInputFormatter;
  final void Function()? onChanged;
  final Widget? icon;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
            controller: controller,
            inputFormatters: textInputFormatter,
            cursorColor: ref.color.onBackground,
            style: ref.typo.subTitle1.copyWith(
              color: ref.color.onBackground,
            ),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ref.color.onBackground,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ref.color.accept,
                  ),
                ),
                suffixIcon: icon),
          ),
        ],
      ),
    );
  }
}
