// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Battle Mode`
  String get battleMode {
    return Intl.message(
      'Battle Mode',
      name: 'battleMode',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Running`
  String get running {
    return Intl.message(
      'Running',
      name: 'running',
      desc: '',
      args: [],
    );
  }

  /// `User Mode`
  String get userMode {
    return Intl.message(
      'User Mode',
      name: 'userMode',
      desc: '',
      args: [],
    );
  }

  /// `Practice Mode`
  String get practiceMode {
    return Intl.message(
      'Practice Mode',
      name: 'practiceMode',
      desc: '',
      args: [],
    );
  }

  /// `Ranking`
  String get ranking {
    return Intl.message(
      'Ranking',
      name: 'ranking',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Achievement`
  String get achievement {
    return Intl.message(
      'Achievement',
      name: 'achievement',
      desc: '',
      args: [],
    );
  }

  /// `Character`
  String get character {
    return Intl.message(
      'Character',
      name: 'character',
      desc: '',
      args: [],
    );
  }

  /// `Record`
  String get record {
    return Intl.message(
      'Record',
      name: 'record',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get recordDetail {
    return Intl.message(
      'Detail',
      name: 'recordDetail',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Login with Kakao`
  String get kakaoLogin {
    return Intl.message(
      'Login with Kakao',
      name: 'kakaoLogin',
      desc: '',
      args: [],
    );
  }

  /// `Button`
  String get semanticsButton {
    return Intl.message(
      'Button',
      name: 'semanticsButton',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get language {
    return Intl.message(
      'language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get currentLanguage {
    return Intl.message(
      'English',
      name: 'currentLanguage',
      desc: '',
      args: [],
    );
  }

  /// `나와 실력이 비슷한 사람과\n대전해보세요`
  String get beforeMatching {
    return Intl.message(
      '나와 실력이 비슷한 사람과\n대전해보세요',
      name: 'beforeMatching',
      desc: '',
      args: [],
    );
  }

  /// `지금 바로 실시간으로 대결할 상대를 찾습니다`
  String get beforeMatchingHint {
    return Intl.message(
      '지금 바로 실시간으로 대결할 상대를 찾습니다',
      name: 'beforeMatchingHint',
      desc: '',
      args: [],
    );
  }

  /// `대결 상대 찾기`
  String get beforeMatchingButton {
    return Intl.message(
      '대결 상대 찾기',
      name: 'beforeMatchingButton',
      desc: '',
      args: [],
    );
  }

  /// `matching`
  String get matching {
    return Intl.message(
      'matching',
      name: 'matching',
      desc: '',
      args: [],
    );
  }

  /// `상대를 찾았습니다\n게임을 수락해주세요`
  String get matched {
    return Intl.message(
      '상대를 찾았습니다\n게임을 수락해주세요',
      name: 'matched',
      desc: '',
      args: [],
    );
  }

  /// `반복적인 매칭 거절 시 게임이용에 제한을 받으실 수 있습니다`
  String get matchedHint {
    return Intl.message(
      '반복적인 매칭 거절 시 게임이용에 제한을 받으실 수 있습니다',
      name: 'matchedHint',
      desc: '',
      args: [],
    );
  }

  /// `waiting for others response`
  String get waitingOthers {
    return Intl.message(
      'waiting for others response',
      name: 'waitingOthers',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `deny`
  String get deny {
    return Intl.message(
      'deny',
      name: 'deny',
      desc: '',
      args: [],
    );
  }

  /// `accept`
  String get accept {
    return Intl.message(
      'accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `giving up`
  String get giveUp {
    return Intl.message(
      'giving up',
      name: 'giveUp',
      desc: '',
      args: [],
    );
  }

  /// `Win`
  String get win {
    return Intl.message(
      'Win',
      name: 'win',
      desc: '',
      args: [],
    );
  }

  /// `Lose`
  String get lose {
    return Intl.message(
      'Lose',
      name: 'lose',
      desc: '',
      args: [],
    );
  }

  /// `Rank Point`
  String get rankPoint {
    return Intl.message(
      'Rank Point',
      name: 'rankPoint',
      desc: '',
      args: [],
    );
  }

  /// `Avg. Pace`
  String get avgPace {
    return Intl.message(
      'Avg. Pace',
      name: 'avgPace',
      desc: '',
      args: [],
    );
  }

  /// `Burned Calory`
  String get caloryBurn {
    return Intl.message(
      'Burned Calory',
      name: 'caloryBurn',
      desc: '',
      args: [],
    );
  }

  /// `Time Taken`
  String get runningTime {
    return Intl.message(
      'Time Taken',
      name: 'runningTime',
      desc: '',
      args: [],
    );
  }

  /// `Best Record`
  String get bestRecord {
    return Intl.message(
      'Best Record',
      name: 'bestRecord',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `정말로 취소하시겠습니까?`
  String get ReallyCancelQuestion {
    return Intl.message(
      '정말로 취소하시겠습니까?',
      name: 'ReallyCancelQuestion',
      desc: '',
      args: [],
    );
  }

  /// `정말로 포기하시겠습니까?\n완료 보상을 획득할 수 없습니다.`
  String get ReallyGiveUpQuestion {
    return Intl.message(
      '정말로 포기하시겠습니까?\n완료 보상을 획득할 수 없습니다.',
      name: 'ReallyGiveUpQuestion',
      desc: '',
      args: [],
    );
  }

  /// `There are no rooms Now\nTry later`
  String get roomEmpty {
    return Intl.message(
      'There are no rooms Now\nTry later',
      name: 'roomEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Make Room`
  String get makeRoom {
    return Intl.message(
      'Make Room',
      name: 'makeRoom',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get waiting {
    return Intl.message(
      'Waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message(
      'In Progress',
      name: 'inProgress',
      desc: '',
      args: [],
    );
  }

  /// `Finding Room`
  String get findRoom {
    return Intl.message(
      'Finding Room',
      name: 'findRoom',
      desc: '',
      args: [],
    );
  }

  /// `Enter search term`
  String get EnterSearchTerm {
    return Intl.message(
      'Enter search term',
      name: 'EnterSearchTerm',
      desc: '',
      args: [],
    );
  }

  /// `Making Room`
  String get makingRoom {
    return Intl.message(
      'Making Room',
      name: 'makingRoom',
      desc: '',
      args: [],
    );
  }

  /// `Public Room`
  String get publicRoom {
    return Intl.message(
      'Public Room',
      name: 'publicRoom',
      desc: '',
      args: [],
    );
  }

  /// `Private Room`
  String get privateRoom {
    return Intl.message(
      'Private Room',
      name: 'privateRoom',
      desc: '',
      args: [],
    );
  }

  /// `The password can be up to 20 characters long.`
  String get roomPasswordRule {
    return Intl.message(
      'The password can be up to 20 characters long.',
      name: 'roomPasswordRule',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Room Name`
  String get roomName {
    return Intl.message(
      'Room Name',
      name: 'roomName',
      desc: '',
      args: [],
    );
  }

  /// `capacity`
  String get capacity {
    return Intl.message(
      'capacity',
      name: 'capacity',
      desc: '',
      args: [],
    );
  }

  /// `distance`
  String get distance {
    return Intl.message(
      'distance',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `create`
  String get create {
    return Intl.message(
      'create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `waiting room`
  String get waitingRoom {
    return Intl.message(
      'waiting room',
      name: 'waitingRoom',
      desc: '',
      args: [],
    );
  }

  /// `Game Start`
  String get gameStart {
    return Intl.message(
      'Game Start',
      name: 'gameStart',
      desc: '',
      args: [],
    );
  }

  /// `invite`
  String get invite {
    return Intl.message(
      'invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `manager`
  String get manager {
    return Intl.message(
      'manager',
      name: 'manager',
      desc: '',
      args: [],
    );
  }

  /// `ready`
  String get ready {
    return Intl.message(
      'ready',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `nickName`
  String get nickname {
    return Intl.message(
      'nickName',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `set nickname`
  String get nicknameSetting {
    return Intl.message(
      'set nickname',
      name: 'nicknameSetting',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profileEdit {
    return Intl.message(
      'Edit Profile',
      name: 'profileEdit',
      desc: '',
      args: [],
    );
  }

  /// `Weight(optional)`
  String get weight {
    return Intl.message(
      'Weight(optional)',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `nickname should be 4 ~ 12 length`
  String get nicknameRule {
    return Intl.message(
      'nickname should be 4 ~ 12 length',
      name: 'nicknameRule',
      desc: '',
      args: [],
    );
  }

  /// `입력한 몸무게는 칼로리 계산에만 사용됩니다.`
  String get weightRule {
    return Intl.message(
      '입력한 몸무게는 칼로리 계산에만 사용됩니다.',
      name: 'weightRule',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get editProfileDone {
    return Intl.message(
      'Done',
      name: 'editProfileDone',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
