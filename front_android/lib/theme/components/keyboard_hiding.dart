import 'package:flutter/material.dart';

class KeyboardHide extends StatelessWidget {
  const KeyboardHide({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: child,
    );
  }
}
