import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/src/view/battle/battle/service/location_permission_service.dart';
import 'package:front_android/theme/components/button.dart';
import 'package:front_android/theme/components/png_image.dart';
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
    void onPressMatchingButton() {
      Navigator.pushNamed(context, RoutePath.matching);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/battleBackground.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const PngImage(
                'matching/matchingStart',
                size: 150,
              ),
              Text(
                S.current.matchingStart,
                textAlign: TextAlign.center,
                style: ref.typo.headline1.copyWith(
                  color: ref.color.onBackground,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                  onPressed: onPressMatchingButton,
                  text: S.current.matchingStartButton,
                  backGroundColor: ref.color.accept,
                  fontColor: ref.color.onAccept,
                ),
              ),
              Text(
                S.current.matchingStartHint,
                style: ref.typo.subTitle4.copyWith(
                  color: ref.color.inactive,
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
