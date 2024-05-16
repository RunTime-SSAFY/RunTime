import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamePage extends ConsumerWidget {
  const GamePage({
    super.key,
    required this.distance,
    required this.color,
    required this.backgroundColor,
  });

  //final Double distance;
  final String distance;
  final Color color;
  final String backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ProviderScope(
      child: Scaffold(
        // //backgroundColor: ref.color.wBackground,
        // appBar: AppBar(
        //   centerTitle: true, // 타이틀 중앙 배치
        //   title: Padding(
        //     padding: const EdgeInsets.only(
        //       // 상단 여백 추가
        //       top: 5.0,
        //     ),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Stack(
        //           // 위젯 겹치기 위해
        //           alignment: Alignment.center, // 증앙 배치
        //           children: [
        //             Container(
        //               width: 28,
        //               height: 28,
        //               decoration: const BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 color: color,
        //               ),
        //             ),
        //             SvgPicture.asset(
        //               // icon 사용
        //               'assets/icons/Activity-Yoga.svg',
        //               width: 20,
        //               height: 20,
        //             ),
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 3,
        //         ),
        //         Text(
        //           'adsf',
        //           style: ref.typo.headline1.copyWith(
        //             color: color,
        //             fontSize: 14,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: Column(
          children: [
            Text('16:31'),
            Column(children: [
              Row(children: [
                Text('600'),
              ])
            ])
          ],
        ),
      ),
    );
  }
}
