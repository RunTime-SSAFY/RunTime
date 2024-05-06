import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class MakeRoomButton extends ConsumerWidget {
  const MakeRoomButton({
    super.key,
    required this.onPress,
  });

  final void Function() onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80,
      width: 80,
      margin: const EdgeInsets.only(right: 30, bottom: 20),
      child: FloatingActionButton(
        onPressed: onPress,
        backgroundColor: ref.color.accept,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: ref.color.onAccept,
              size: 40,
            ),
            Text(
              S.current.makeRoom,
              style: ref.typo.subTitle3.copyWith(
                color: ref.color.onAccept,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
