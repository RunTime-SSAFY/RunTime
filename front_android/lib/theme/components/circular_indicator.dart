import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class CircularIndicator extends ConsumerWidget {
  const CircularIndicator({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: isLoading ? 1 : 0,
        child: Container(
          color: ref.color.black,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: ref.color.inactive,
          ),
        ),
      ),
    );
  }
}
