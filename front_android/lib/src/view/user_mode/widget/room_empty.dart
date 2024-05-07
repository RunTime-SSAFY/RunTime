import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class RoomEmpty extends ConsumerWidget {
  const RoomEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Center(
        child: Text(
          S.current.roomEmpty,
          style: ref.typo.subTitle3.copyWith(
            color: ref.color.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
