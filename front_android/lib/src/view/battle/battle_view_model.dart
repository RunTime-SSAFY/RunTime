import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/distance_repository.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/theme/components/dialog/cancel_dialog.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

final battleViewModelProvider = ChangeNotifierProvider.autoDispose((ref) {
  var battleData = ref.watch(battleDataServiceProvider);
  return BattleViewModel(battleData);
});

class BattleViewModel with ChangeNotifier {
  final BattleDataService _battleData;

  List<Participant> get participants =>
      _battleData.getBattleDataSortByDistance();

  BattleViewModel(this._battleData) {
    var mode = _battleData.mode;

    // DistanceRepository 시작 - 거리 측정 및 서버에 보내기 시작
    distanceService = DistanceRepository(
      sendDestination:
          DestinationHelper.getBattleDestination(mode, _battleData.uuid),
      socket: _battleData.stompInstance,
      roomId: _battleData.roomId,
    );

    distanceService.listenLocation();

    // 데이터 구독 시작
    _battleData.stompInstance.subScribe(
        destination: DestinationHelper.getForSub(mode, _battleData.uuid),
        callback: (p0) {
          var newParticipantsData =
              Participant.fromJson(jsonDecode(p0.body!)['data']);
          _battleData.changeParticipantsDistance(newParticipantsData);
        });
    _startTimer();
  }

  late final DistanceRepository distanceService;

  double get currentDistance => distanceService.currentDistance;

  String get result {
    if (_battleData.mode != BattleModeHelper.userMode) {
      return _battleData.result == 1 ? S.current.win : S.current.lose;
    } else {
      return '${_battleData.result.toString()}등';
    }
  }

  int _point = 30;
  String get point => _point > 0 ? '+$_point' : '$_point';
  final String character = UserService.instance.characterImgUrl;
  double get targetDistance => _battleData.targetDistance;

  double _avgPace = 0;
  double get avgPace => _avgPace;

  double _calory = 0;

  String get calory => _calory.toStringAsFixed(2);

  final DateTime _date = DateTime.now();

  String get date => DateFormat(DateFormat.YEAR_MONTH_DAY).format(_date);

  // GPS 초기 설정을 위해 로딩 시간 제외
  final DateTime _startTime = DateTime.now().add(const Duration(seconds: 4));
  DateTime _currentTime = DateTime.now();
  String get runningTime => _currentTime.difference(_startTime).toHhMmSs();

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentTime = DateTime.now();
      var seconds = _currentTime.difference(_startTime).inSeconds;
      _avgPace = _calculateTimePerKilometer(currentDistance, seconds);
      var velocity = distanceService.instantaneousVelocity;
      _calory +=
          velocity == 0 ? 0 : 157 * ((0.1 * velocity + 3.5) / 3.5) / 1000;

      addPolyLine();

      notifyListeners();
    });
  }

  double _calculateTimePerKilometer(
      double distanceInMeters, int elapsedTimeInSeconds) {
    if (elapsedTimeInSeconds == 0) {
      return 0;
    }

    double secondsPerMeter = distanceInMeters / elapsedTimeInSeconds;
    if (secondsPerMeter == 0) {
      return 0;
    }
    double timeForOneKilometerInSeconds = 1000 / secondsPerMeter;
    double timeForOneKilometerInMinutes =
        (timeForOneKilometerInSeconds / 6).round() / 10;

    return timeForOneKilometerInMinutes;
  }

  void onGiveUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CancelDialog(
          onAcceptCancel: () {
            context.pushReplacement(RoutePathHelper.battleResult);
            _timer.cancel();
            distanceService.cancelListen();
            _battleData.disconnect();
          },
          title: S.current.giveUp,
          content: S.current.ReallyGiveUpQuestion,
        );
      },
    );
  }

  void onBattleDone(BuildContext context) {
    _timer.cancel();
    distanceService.cancelListen();
    _battleData.disconnect();
    context.pushReplacement(RoutePathHelper.battleResult);
  }

  void onResultDone(BuildContext context) {
    context.pushReplacement(RoutePathHelper.runMain);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 배틀 결과
  void getResult() async {
    distanceService.cancelListen();
    if (_battleData.result != 0) return;

    _isLoading = true;
    notifyListeners();

    distanceService.cancelListen();

    try {
      await Future.delayed(const Duration(microseconds: 500));

      final results = await Future.wait([
        apiInstance.get('api/matchings/${_battleData.roomId}/ranking'),
        Future.delayed(const Duration(milliseconds: 500)),
      ]);

      _battleData.result = results[0].data['ranking'];

      FormData formData = FormData.fromMap({
        'gameMode': _battleData.mode,
        'ranking': _battleData.result,
        'distance': currentDistance,
        'runStartTime': _startTime,
        'runEndTime': _currentTime,
        'pace': avgPace,
        'calory': double.parse(calory),
        'file': MultipartFile.fromBytes(
          imageBytes ?? Uint8List(0),
          filename:
              '${UserService.instance.nickname}END${DateTime.now().toString()}',
        ),
      });

      final response = await apiInstance.post(
        'api/results',
        data: formData,
      );

      var tierDto = jsonDecode(response.data)['tierDto'];

      _point = tierDto['afterScore'] - tierDto['beforeScore'];

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // GoogleMap
  Set<Polyline> polyLines = {};

  List<LatLng> points = [];

  void addPolyLine() {
    if (distanceService.lastPosition != null) {
      points.add(
        LatLng(
          distanceService.lastPosition!.latitude,
          distanceService.lastPosition!.longitude,
        ),
      );
      polyLines = {
        Polyline(
          polylineId: PolylineId('${polyLines.length}'),
          points: points,
          width: 4,
        ),
      };
    }
  }

  // widgetsToImage
  Uint8List? imageBytes;

  @override
  void dispose() {
    distanceService.cancelListen();
    _battleData.dispose();
    _battleData.stompInstance.disconnect();
    super.dispose();
  }
}
