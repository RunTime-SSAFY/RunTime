// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:front_android/src/service/theme_service.dart';
// import 'package:front_android/src/view/run_main/run_main_view_model.dart';
// import 'package:front_android/src/view/run_main/widgets/battle_mode_button.dart';
// import 'package:front_android/src/view/run_main/widgets/run_main_button.dart';
// import 'package:front_android/theme/components/keyboard_hiding.dart';
// import 'package:front_android/theme/components/png_image.dart';
// import 'package:front_android/theme/components/svg_icon.dart';
// import 'package:front_android/util/helper/route_path_helper.dart';
// import 'package:front_android/util/lang/generated/l10n.dart';

// class RunMainView extends ConsumerStatefulWidget {
//   const RunMainView({super.key});

//   @override
//   ConsumerState<RunMainView> createState() => _RunMainViewState();
// }

// class _RunMainViewState extends ConsumerState<RunMainView> {
//   late RunMainViewModel viewModel;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) {
//         viewModel.noNickName(context);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     viewModel = ref.watch(runMainProvider);
//     return KeyboardHide(
//       child: Container(
//         decoration: const BoxDecoration(
//             color: Colors.white,
//             image: DecorationImage(
//                 fit: BoxFit.fitHeight,
//                 image: AssetImage(
//                     'assets/images/background/runMainBackground.png'))),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             title: Text(
//               S.current.running,
//               style: ref.typo.appBarMainTitle,
//             ),
//             actions: const [
//               Padding(
//                 padding: EdgeInsets.only(right: 20),
//                 child: SvgIcon(
//                   'bell',
//                 ),
//               ),
//             ],
//           ),
//           body: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 10,
//             ),
//             child: Stack(
//               children: [
//                 Positioned(
//                   bottom: min(-MediaQuery.of(context).size.height / 10, -180),
//                   child: const PngImage(
//                     'main_run_image',
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     const BattleModeButton(),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: RunMainButton(
//                             modeName: S.current.userMode,
//                             modeRoute: RoutePathHelper.userMode,
//                             cardColor: ref.color.userMode,
//                           ),
//                         ),
//                         Expanded(
//                           child: RunMainButton(
//                             modeName: S.current.practiceMode,
//                             modeRoute: RoutePathHelper.practiceMode,
//                             cardColor: ref.color.practiceMode,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Spacer(),
//                         Expanded(
//                           child: RunMainButton(
//                             modeName: S.current.ranking,
//                             modeRoute: RoutePathHelper.ranking,
//                             cardColor: ref.color.rankingButton,
//                           ),
//                         )
//                       ],
//                     ),
//                     const Spacer()
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
