import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class BaseDialog extends ConsumerWidget {
  const BaseDialog({
    super.key,
    this.title,
    required this.child,
    this.actions,
  });

  final String? title;
  final Widget child;
  final Widget? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      backgroundColor: ref.color.surface,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        16,
      )),
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.all(16).copyWith(
        top: title != null ? 0 : 16,
      ),
      title: title != null
          ? Text(
              title!,
              style: ref.typo.headline2,
              textAlign: TextAlign.center,
            )
          : null,
      children: [
        child,
        if (actions != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: actions!,
          ),
      ],
    );
  }
}
