import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/view/record/record_view_model.dart';
import 'package:front_android/src/view/record/widgets/record_list.dart';
import 'package:front_android/src/view/record/widgets/record_top.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/circular_indicator.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class RecordView extends ConsumerStatefulWidget {
  const RecordView({super.key});

  @override
  ConsumerState<RecordView> createState() => _RecordViewState();
}

// 기록을 표시하는 위젯
class _RecordViewState extends ConsumerState<RecordView> {
  late RecordViewModel viewModel;

  @override
  void initState() {
    super.initState();
    // 위젯 빌드 후 실행(viewModel 받와야 사용 가능)
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.fetchRecordList(
        gameMode: viewModel.gameMode,
        pageSize: 10,
        lastId: viewModel.lastId,
      );
      print("--------[RecordView] initState --------");
      print(viewModel.recordList);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(recordViewModelProvider); // 뷰 모델 가져오기
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.record,
          style: ref.typo.appBarMainTitle,
        ),
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 20),
        //     child: SvgIcon('bell'),
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RecordTop(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RecordList(
                    pageSize: 10,
                    gameMode: viewModel.gameMode,
                    recordList: viewModel.recordList,
                    hasNext: viewModel.hasNext,
                    lastId: viewModel.lastId,
                  ),
                ),
              ),
            ],
          ),
          if (viewModel.isLoading)
            CircularIndicator(isLoading: viewModel.isLoading),
        ],
      ),
    );
  }
}
