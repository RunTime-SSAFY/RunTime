import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/location_permission_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/run_main/run_main_view_model.dart';
import 'package:front_android/src/view/run_main/widgets/battle_mode_button.dart';
import 'package:front_android/src/view/run_main/widgets/run_main_button.dart';
import 'package:front_android/theme/components/keyboard_hiding.dart';
import 'package:front_android/theme/components/png_image.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class RunMainView extends ConsumerStatefulWidget {
  const RunMainView({super.key});

  @override
  ConsumerState<RunMainView> createState() => _RunMainViewState();
}

class _RunMainViewState extends ConsumerState<RunMainView> {
  late RunMainViewModel viewModel;
  bool _dataFetched = false;

  @override
  void initState() {
    super.initState();
    _dataFetched = false;

    void init() async {
      await LocationPermissionService.getPermission();

      if (!mounted) return;

      if (mounted) {
        setState(() {});
      }
    }

    init();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        viewModel.noNickName(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(runMainProvider);
    if (!_dataFetched) {
      viewModel.fetchingData(context);
      _dataFetched = true;
    }

    return KeyboardHide(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            S.current.running,
            style: ref.typo.appBarMainTitle,
          ),
        ),
        body: Stack(
          children: [
            // 배경 이미지1
            Positioned(
              // 가운데 아래로 정렬
              bottom: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: const PngImage('background/runMainBackground',
                    fit: BoxFit.fitHeight),
              ),
            ),
            // 배경 이미지2
            Positioned(
              left: 20,
              bottom: max(-MediaQuery.of(context).size.height / 50, -20),
              child: PngImage(
                'main_run_image',
                // 카드크기만큼 넓이 설정 (20: 왼쪽패딩, 20: 오른쪽패딩, 20: 버튼간격)
                width: (MediaQuery.of(context).size.width - 20 - 20 - 20) / 2,
              ),
            ),
            // 카드버튼 리스트
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // 대결모드 버튼
                  const BattleModeButton(),
                  const SizedBox(height: 20),
                  // 두번째 줄
                  Row(
                    children: [
                      // 사용자모드 버튼
                      Expanded(
                        child: RunMainButton(
                          modeName: S.current.userMode,
                          modeRoute: RoutePathHelper.userMode,
                          cardColor1: ref.palette.purple600,
                          cardColor2: ref.palette.purple400,
                        ),
                      ),
                      const SizedBox(width: 20),

                      // 연습모드 버튼
                      Expanded(
                        child: RunMainButton(
                          modeName: S.current.practiceMode,
                          modeRoute: RoutePathHelper.practiceMode,
                          cardColor1: ref.palette.red600,
                          cardColor2: ref.palette.red400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 랭킹 버튼
                  Row(
                    children: [
                      const Spacer(),
                      const SizedBox(width: 20),
                      Expanded(
                        child: RunMainButton(
                          modeName: S.current.ranking,
                          modeRoute: RoutePathHelper.ranking,
                          cardColor1: ref.palette.orange500,
                          cardColor2: ref.palette.orange300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
