import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/src/view/matching/widgets/matching_layout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/countdown_progress_bar.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class Matched extends ConsumerStatefulWidget {
  const Matched({super.key});

  @override
  ConsumerState<Matched> createState() => _Matched();
}

// 주석: 수락 누르면 소켓 연결 ->
// 상대도 연결되면 서버에서 달릴 거리 받고 전역에 저장 ->
// 배틀 화면으로 이동

class _Matched extends ConsumerState<Matched> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(matchingViewModelProvider);

    return MatchingLayoutView(
      button: Row(
        children: [
          Expanded(
            child: Button(
              onPressed: () => viewModel.acceptBattle(false),
              text: S.current.deny,
              backGroundColor: ref.color.deny,
              fontColor: ref.color.onDeny,
              isInactive: viewModel.isAccepted,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Button(
              onPressed: () => viewModel.acceptBattle(true),
              text: S.current.accept,
              backGroundColor: ref.color.accept,
              fontColor: ref.color.onAccept,
              isInactive: viewModel.isAccepted,
            ),
          ),
        ],
      ),
      hintMessage: Text(
        S.current.matchedHint,
        style: ref.typo.subTitle4.copyWith(
          color: ref.color.inactive,
        ),
      ),
      middleWidget: Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CountdownProgressBar(
              handleTimeOut: () => viewModel.acceptBattle(false),
              seconds: 5,
              valueColor: ref.color.accept,
              flipHorizontally: true,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
