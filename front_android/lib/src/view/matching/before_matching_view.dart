import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/location_permission_service.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/src/view/matching/widgets/matching_layout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class StartMatchingView extends ConsumerStatefulWidget {
  const StartMatchingView({super.key});

  @override
  ConsumerState<StartMatchingView> createState() => _StartMatchingViewState();
}

class _StartMatchingViewState extends ConsumerState<StartMatchingView> {
  @override
  void initState() {
    super.initState();

    void init() async {
      bool locationPermission = await LocationPermissionService.getPermission();

      if (!mounted) return;

      if (!locationPermission) {
        Navigator.pop(context);
      }
      if (mounted) {
        setState(() {});
      }
    }

    init();
  }

  @override
  Widget build(BuildContext context) {
    MatchingViewModel viewModel = ref.watch(matchingViewModelProvider);

    return MatchingLayoutView(
      image: 'beforeMatching',
      mainMessage: S.current.beforeMatching,
      button: Button(
        onPressed: () => viewModel.toMatchingStartView(context),
        text: S.current.beforeMatchingButton,
        backGroundColor: ref.color.accept,
        fontColor: ref.color.onAccept,
      ),
    );
  }
}
