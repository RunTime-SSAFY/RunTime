import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/record_detail.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/record_detail/record_detail_view_model.dart';
import 'package:front_android/src/view/record_detail/widgets/record_detail_top.dart';
import 'package:front_android/src/view/record_detail/widgets/record_detail_bottom.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/circular_indicator.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import 'package:front_android/src/model/record.dart';

class RecordDetailView extends ConsumerStatefulWidget {
  const RecordDetailView({
    required this.recordDetail,
    super.key,
  });
  final RecordDetail recordDetail;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecordDetailViewState();
}

class _RecordDetailViewState extends ConsumerState<RecordDetailView> {
  late RecordDetailViewModel viewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getRecord(widget.recordDetail.recordId);
      print("--------[RecordDetailView] initState --------");
      print(viewModel.record);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(recordDetailViewModelProvider);

    Record? record = viewModel.record;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          color: ref.color.black,
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Text(
          S.current.recordDetail,
          style: ref.typo.appBarSubTitle,
        ),
      ),
      body: Stack(
        children: [
          if (record != null)
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                children: [
                  RecordDetailTop(
                    recordDetail: widget.recordDetail,
                    gameMode: record.gameMode!,
                    ranking: record.ranking!,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: RecordDetailBottom(record: record),
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
          if (viewModel.isLoading)
            CircularIndicator(isLoading: viewModel.isLoading),
        ],
      ),
    );
  }
}
