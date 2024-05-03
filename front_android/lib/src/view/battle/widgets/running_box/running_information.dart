import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RunningInformation extends StatelessWidget {
  const RunningInformation({super.key});

  // 소켓으로 나와 상대의 거리 정보 가져오기

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Placeholder(),
          ),
          Row(
            children: [Text('cd'), Text('fwa')],
          ),
          Expanded(
            flex: 1,
            child: Placeholder(),
          ),
          Text('dwa'),
          Expanded(
            flex: 3,
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
