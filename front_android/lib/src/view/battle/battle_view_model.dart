import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/model/battle.dart';
import 'package:front_android/src/repository/distance_repository.dart';
import 'package:front_android/src/service/battle_data_service.dart';
import 'package:front_android/src/service/https_request_service.dart';
import 'package:front_android/src/service/tts_service.dart';
import 'package:front_android/src/service/user_service.dart';
import 'package:front_android/src/view/battle/widgets/give_up_dialog.dart';
import 'package:front_android/util/helper/battle_helper.dart';
import 'package:front_android/util/helper/extension.dart';
import 'package:front_android/util/helper/number_format_helper.dart';
import 'package:front_android/util/helper/route_path_helper.dart';
import 'package:front_android/util/lang/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

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
      sendDestination: DestinationHelper.getForSend(mode, _battleData.uuid),
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

    // TTS 시작
    ttsService.startTts();
  }

  late final DistanceRepository distanceService;

  double get currentDistance => distanceService.currentDistance;

  String get result {
    if (_battleData.mode != BattleModeHelper.userMode) {
      return _battleData.result == 1 ? S.current.win : S.current.lose;
    } else {
      switch (_battleData.result) {
        case 0:
          return 'failed';
        case 1:
          return '1st';
        case 2:
          return '2nd';
        case 3:
          return '3rd';
        default:
          return '${_battleData.result}th';
      }
    }
  }

  int _point = 0;
  String get point => _point > 0 ? '+$_point' : '$_point';
  final String character = UserService.instance.characterImgUrl;
  double get targetDistance => _battleData.targetDistance;

  double _avgPace = 0;
  int get avgPace => (_avgPace * 100).toInt();

  double _calorie = 0;

  String get calorie => NumberFormatHelper.floatTrunk(_calorie);

  final DateTime _date = DateTime.now();

  String get date => DateFormat(DateFormat.YEAR_MONTH_DAY).format(_date);
  get dateOriginal => _date;

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
      _calorie +=
          velocity == 0 ? 0 : 157 * ((0.1 * velocity + 3.5) / 3.5) / 1000;

      addPolyLine();

      if (ttsDuration > 15) {
        ttsService.addMessage(
          '도착까지 ${targetDistance.toInt() - distanceService.currentDistance.toInt()}m 남았습니다.',
        );
        ttsDuration = 0;
      } else {
        ttsDuration++;
      }

      var newLastRank = participants.indexWhere(
              (element) => element.nickname == UserService.instance.nickname) +
          1;
      if (lastRank != 0) {
        if (lastRank > newLastRank) {
          ttsService.addMessage('상대방을 추월하였습니다. 현재$newLastRank등입니다.');
        } else if (lastRank < newLastRank) {
          ttsService.addMessage('추월 당하였습니다. 현재$newLastRank등입니다.');
        }
      } else {
        lastRank = participants.indexWhere((element) =>
                element.nickname == UserService.instance.nickname) +
            1;
      }

      lastRank = newLastRank;
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

  Future<void> onBattleDone(BuildContext context) async {
    _timer.cancel();
    ttsService.endTts();
    distanceService.cancelListen();
    _battleData.disconnect();

    context.pushReplacement(RoutePathHelper.battleResult);
  }

  void onResultDone(BuildContext context) {
    context.go(RoutePathHelper.runMain);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // 배틀 결과
  void getResult() async {
    _isLoading = true;
    notifyListeners();

    try {
      try {
        final results = await Future.wait([
          apiInstance.get(
              'api/${BattleModeHelper.getRankingReceive(_battleData.mode)}/${_battleData.roomId}/ranking'),
          Future.delayed(const Duration(milliseconds: 500)),
        ]);

        _battleData.result = results[0].data['ranking'];
      } catch (error) {
        debugPrint('완주 못했어요');
      }

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/temp.png';

      // Uint8List 데이터를 파일로 저장합니다.
      final file = File(filePath);
      await file.writeAsBytes(imageBytes ?? Uint8List(0));

      var multipartFile = await MultipartFile.fromFile(
        filePath,
        filename:
            '${UserService.instance.nickname}END${DateTime.now().toString()}.png',
      );

      FormData formData = FormData.fromMap(
        {
          'gameMode': BattleModeHelper.getModeName(_battleData.mode),
          'ranking': _battleData.result,
          'distance': double.parse((currentDistance / 1000).toStringAsFixed(2)),
          'runStartTime': _startTime.toIso8601String(),
          'runEndTime': _currentTime.toIso8601String(),
          'pace': avgPace,
          'calorie': double.parse(calorie).toInt(),
          'file': multipartFile,
        },
      );

      final response = await apiInstance.post(
        'api/results',
        data: formData,
      );

      var recordId = response.data['id'];
      try {
        apiInstance.post(
          'api/realtime-records',
          data: {
            'recordId': recordId,
            'roomId': _battleData.roomId,
          },
        );
      } catch (error) {
        debugPrint(error.toString());
      }

      _point = response.data['afterScore'] - response.data['beforeScore'];
    } catch (error) {
      debugPrint(error.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // GoogleMap
  late GoogleMapController mapController;
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
          color: Colors.red,
        ),
      };
    }
  }

  // widgetsToImage
  Uint8List? imageBytes;
  bool stopCamera = false;
  bool cameraMoving = false;

  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();

  Future<void> captureImage() async {
    cameraMoving = true;
    notifyListeners();

    if (points.length < 2) return;

    // 초기 최소값과 최대값을 첫 번째 점으로 설정
    double minLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLat = points[0].latitude;
    double maxLng = points[0].longitude;

    // 모든 점을 순회하며 최소값과 최대값 업데이트
    for (LatLng point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    await mapController.moveCamera(CameraUpdate.newLatLngBounds(bounds, 50));

    // 카메라 변경 시간
    await Future.delayed(const Duration(milliseconds: 300));

    imageBytes = await widgetsToImageController.capture();

    cameraMoving = false;
    notifyListeners();
  }

  // TTS
  TtsService ttsService = TtsService();
  int ttsDuration = 0;
  int lastRank = 0;

  @override
  void dispose() {
    distanceService.cancelListen();
    ttsService.endTts();
    _battleData.dispose();
    _battleData.stompInstance.disconnect();
    super.dispose();
  }
}
