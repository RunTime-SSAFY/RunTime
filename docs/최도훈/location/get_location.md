```
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  final StreamController<void> _locationStreamController = StreamController();
  Location location = Location();

  @override
  void initState() {
    super.initState();

    // 0.5초마다 요청
    // getLocation은 5초마다 최신 상태 업데이트 한다.
    // 더 짧은 간격으로 위치정보 불러오려면 onLocationChanged와
    // location 객체의 changeSettings 메서드에서 interval을 설정한다.
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _locationStreamController
          .add(null); // _requestController에 빈 객체 추가하여 요청 전달
    });

    _locationStreamController.stream.listen(
      (_) {
        getLocation();
      },
    );
  }

  LocationData? _location;
  String? _error;

  Future<void> getLocation() async {
    _location = null;
    _error = null;

    try {
      final locationResult = await location.getLocation();
      setState(() {
        _location = locationResult;
      });
      debugPrint("현재 위치: ${locationResult.toString()}");
    } on PlatformException catch (err) {
      setState(() {
        _error = err.message;
      });
      debugPrint("위치를 가져오는 중 에러가 발생했습니다.\n${err.message}");
      debugPrint("에러 스택:\n$err.stacktrace}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location: ${_error ?? '${_location ?? "unknown"}'}',
        ),
        Text(
          DateTime.now().toIso8601String(),
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
```
