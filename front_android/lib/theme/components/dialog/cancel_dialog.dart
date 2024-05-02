import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/dialog/base_dialog.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class CancelDialog extends ConsumerWidget {
  const CancelDialog({
    super.key,
    required this.onCancel,
  });

  final void Function() onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseDialog(
      title: S.current.cancel,
      content: Text(
        S.current.ReallyCancelQuestion,
        style: ref.typo.subTitle4,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: Button(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: S.current.deny,
                backGroundColor: ref.color.deny,
                fontColor: ref.color.onDeny,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Button(
                onPressed: () {
                  onCancel();
                  Navigator.pop(context);
                },
                text: S.current.accept,
                backGroundColor: ref.color.accept,
                fontColor: ref.color.onAccept,
              ),
            )
          ],
        ),
      ],
    );
  }
}
