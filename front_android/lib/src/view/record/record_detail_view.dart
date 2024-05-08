import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class RecordDetailView extends ConsumerWidget {
  // final Record record;
  // const RecordDetailView({super.key, required this.record});
  const RecordDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: ref.color.black,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          S.current.recordDetail,
          style: ref.typo.appBarSubTitle,
        ),
        actions: [],
      ),
      body: const Center(),
    );
  }
}
