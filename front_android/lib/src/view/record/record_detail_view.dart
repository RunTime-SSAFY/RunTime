import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/record/widgets/record_detail/record_detail_mode_info.dart';
import 'package:front_android/src/view/record/widgets/record_detail/record_detail_result_card.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

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
            GoRouter.of(context).pop();
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
      body: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: [
            const RecordDetailModeInfo(),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: RecordDetailResultCard(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Button(
                  onPressed: () {},
                  text: '공유하기',
                  backGroundColor: ref.color.accept,
                  fontColor: ref.color.white),
            ),
          ],
        ),
      ),
    );
  }
}
