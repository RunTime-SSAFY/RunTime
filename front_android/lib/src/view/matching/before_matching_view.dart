import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/widgets/gps_location/location_permission_service.dart';
import 'package:front_android/src/view/matching/matching_view_model.dart';
import 'package:front_android/src/view/matching/widgets/matching_layout.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:front_android/util/route_path.dart';

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
    viewModel.matchingState = MatchingState.beforeMatching;

    void onPressMatchingButton() {
      Navigator.pushNamed(context, RoutePath.matching);
    }

    return MatchingLayoutView(
      button: Button(
        onPressed: onPressMatchingButton,
        text: S.current.beforeMatchingButton,
        backGroundColor: ref.color.accept,
        fontColor: ref.color.onAccept,
      ),
    );
  }
}
