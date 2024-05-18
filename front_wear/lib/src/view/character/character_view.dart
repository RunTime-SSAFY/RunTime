import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CharacterView extends StatefulWidget {
  const CharacterView({super.key});

  @override
  _CharacterViewState createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {
  // 임시 캐릭터 데이터 리스트
  List<Map<String, String>> characters = [
    {"image": "assets/icons/lock.svg", "name": "고슴도치"},
    {"image": "assets/icons/lock.svg", "name": "여우"},
    {"image": "assets/icons/lock.svg", "name": "토끼"},
    {"image": "assets/icons/lock.svg", "name": "곰"},
    {"image": "assets/icons/lock.svg", "name": "사슴"},
    {"image": "assets/icons/lock.svg", "name": "호랑이"},
    {"image": "assets/icons/lock.svg", "name": "사자"},
    {"image": "assets/icons/lock.svg", "name": "기린"},
    {"image": "assets/icons/lock.svg", "name": "코끼리"},
    {"image": "assets/icons/lock.svg", "name": "판다"},
    {"image": "assets/icons/lock.svg", "name": "늑대"},
    {"image": "assets/icons/lock.svg", "name": "하마"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('캐릭터 선택'),
      ),
      body: GridView.count(
        crossAxisCount: 4,  // 한 줄에 4개의 캐릭터
        childAspectRatio: (1 / 1.5), // 캐릭터의 가로 세로 비율
        children: characters.map((character) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(character["image"]!, height: 60),
                Text(character["name"]!),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:front_wear/src/view/character/character_info.dart';

// class Character extends ConsumerWidget {
//   const Character({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       home: Scaffold(
//         body: //Container(
//             Container(
//           child: ElevatedButton(
//             onPressed: () {
//               // Navigator를 사용하여 CharacterView 화면으로 전환합니다.
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const CharacterView(),
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               minimumSize: const Size(100, 162),
//             ),
//             child: Column(
//               children: [
//                 SvgPicture.asset('assets/icons/lock.svg'),
//                 Image.asset('assets/images/hedgehog.png'),
//                 const Text('고슴도치')
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CharacterView extends StatefulWidget {
//   const CharacterView({super.key});

//   //const CharacterInfo({super.key});

//   //const CharacterInfo({super.key});
//   @override
//   _CharacterInfoState createState() => _CharacterInfoState();
// }

// class _CharacterInfoState extends State<CharacterView> {
//   // 모달 다이얼로그를 보여주는 함수
//   void _showModalDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // 여기서 다이얼로그의 모양을 정의할 수 있습니다.
//         return AlertDialog(
//           title: const Text('모달 다이얼로그'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('캐릭터 이름: Flutter Hero'),
//                 Text('레벨: 99'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('닫기'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // 다이얼로그 닫기
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton(
//               onPressed: _showModalDialog,
//               child: const Text('캐릭터 정보 보기'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
