import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordListItem extends ConsumerWidget {
  const RecordListItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400, // 전체 컨테이너의 가로 길이
          height: 100, // 전체 컨테이너의 세로 길이
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3), // 테두리 색상 및 두께
            color: Colors.black, // 배경 색상
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // 왼쪽 큰 사각형
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.grey[800], // 버튼 색상
                ),
              ),
              // 오른쪽 세 개의 사각형
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 25,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 25,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
