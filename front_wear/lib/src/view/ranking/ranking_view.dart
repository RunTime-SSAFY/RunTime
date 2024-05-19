import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ranking extends ConsumerWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 예제 데이터: 실제 애플리케이션에서는 이 부분을 API 호출 등으로 대체할 수 있습니다.
    final List<Map<String, dynamic>> rankings = List.generate(10, (index) {
      return {
        'rank': index + 1,
        'nickname': 'Player ${index + 1}',
        'imageUrl': 'https://via.placeholder.com/150'
      };
    });

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Top 10',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: rankings.length,
          itemBuilder: (context, index) {
            final ranking = rankings[index];
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  // 등수
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '${ranking['rank']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // 닉네임
                  Expanded(
                    child: Text(
                      ranking['nickname'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // 사용자 이미지
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(ranking['imageUrl']),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Ranking extends ConsumerWidget {
//   const Ranking({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
          
//           child: Container(
//             width: 380,
//             height: 100,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             decoration: const BoxDecoration(
//               color: Colors.grey,
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//             ),
//             child: Row(
//               children: [
//                 // 등수를 표시하는 부분
//                 Container(
//                   width: 40,
//                   alignment: Alignment.center,
//                   child: const Text(
//                     '1',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 // 닉네임
//                 const Expanded(
//                   child: Text(
//                     'Flutter Master',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 // 사용자 이미지
//                 // CircleAvatar(
//                 //   radius: 30,
//                 //   backgroundImage: NetworkImage('https://via.placeholder.com/150'),
//                 // ),
//                 Image.asset('assets/images/hedgehog.png'),
//                 const SizedBox(width: 10),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
