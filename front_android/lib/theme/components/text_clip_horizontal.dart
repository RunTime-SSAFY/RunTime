import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextClipHorizontal extends ConsumerWidget {
  const TextClipHorizontal({
    required this.child,
    super.key,
  });

  final Text child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRect(
      child: Align(
        alignment: Alignment.center,
        heightFactor: 0.8,
        child: child,
      ),
    );
  }
}
