import 'package:flutter/material.dart';

class CharacterInfo extends StatefulWidget {
  const CharacterInfo({super.key});

  //const CharacterInfo({super.key});
  @override
  _CharacterInfoState createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  // 모달 다이얼로그를 보여주는 함수
  void _showModalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // 여기서 다이얼로그의 모양을 정의할 수 있습니다.
        return AlertDialog(
          title: const Text('모달 다이얼로그'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('캐릭터 이름: Flutter Hero'),
                Text('레벨: 99'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('캐릭터 보기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: _showModalDialog,
              child: const Text('캐릭터 정보 보기'),
            ),
          ],
        ),
      ),
    );
  }
}
