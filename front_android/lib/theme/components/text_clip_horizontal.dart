import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextClipHorizontal extends ConsumerWidget {
  const TextClipHorizontal({
    this.alignment = Alignment.center,
    this.clipFactor = 0.8,
    required this.child,
    super.key,
  });

  /// The factor by which to clip the height of the child widget.
  ///
  /// A value of 1.0 means no clipping, while a value of 0.5 means half of the
  /// child's height will be clipped. Default value is 0.8.
  final double clipFactor;
  final Alignment alignment;
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRect(
      child: Align(
        alignment: alignment,
        heightFactor: clipFactor,
        child: child,
      ),
    );
  }
}
