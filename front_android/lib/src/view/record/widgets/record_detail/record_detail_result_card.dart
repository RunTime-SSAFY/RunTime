import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';

class RecordDetailResultCard extends ConsumerWidget {
  const RecordDetailResultCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        // 지도
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/record_course.png', // 임시 이미지
              fit: BoxFit.cover, // 이미지 크기 조정 => cover: 이미지가 잘리지 않고 꽉 채움
              alignment: const Alignment(0.0, 9.0), // 이미지 위치 조정
            ),
          ),
        ),
        // Overlay 검은색 배경
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.3, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // 아래부터 쌓이게
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 달린거리 및 날짜시간
                      Column(
                        // 왼쪽으로 붙이기
                        crossAxisAlignment: CrossAxisAlignment.start,

                        // 요소 간격 줄이기
                        children: [
                          Text(
                            '1km',
                            style: ref.typo.subTitle1.copyWith(
                              fontSize: 34,
                              color: ref.color.white,
                            ),
                          ),
                          Text(
                            '2024. 4. 26. 19:20',
                            style: ref.typo.subTitle4.copyWith(
                              color: ref.palette.gray300,
                            ),
                          ),
                        ],
                      ),

                      // 평균페이스
                      Column(
                        children: [
                          Text(
                            '평균페이스',
                            style: ref.typo.subTitle4.copyWith(
                              color: ref.palette.gray300,
                            ),
                          ),
                          Text(
                            '630',
                            style: ref.typo.subTitle1.copyWith(
                              fontSize: 30,
                              color: ref.color.white,
                            ),
                          ),
                        ],
                      ),

                      // 소모 칼로리
                      Column(
                        children: [
                          Text(
                            '소모칼로리',
                            style: ref.typo.subTitle4.copyWith(
                              color: ref.palette.gray300,
                            ),
                          ),
                          Text(
                            '157kcal',
                            style: ref.typo.subTitle1.copyWith(
                              fontSize: 30,
                              color: ref.color.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Text(
                  //     '걸린 시간',
                  //     style: ref.typo.subTitle4.copyWith(
                  //       color: ref.color.white,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '6분 30초',
                      style: ref.typo.headline1.copyWith(
                        fontSize: 50,
                        fontWeight: ref.typo.bold,
                        color: ref.color.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
