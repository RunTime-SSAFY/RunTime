enum RouteParameter {
  targetDistance;
}

interface class RoutePathHelper {
  // 로그인 & 메인
  static const String login = '/login';
  static const String runMain = '/runMain';

  // 배틀
  static const String battle = '/battle';
  static const String battleResult = '/battleResult';

  // 매칭
  static const String beforeMatching = '/beforeMatching';
  static const String matching = '/matching';
  static const String matched = '/matched';

  // 유저 모드
  static const String userMode = '/userMode';
  static const String waitingRoom = '/waitingRoom:roomId';
  static String waitingRoomWithId(int roomId) => '/waitingRoom$roomId';
  static const String userModeSearch = '/userModeSearch';

  // 연습 모드
  static const String practiceMode = '/practiceMode';

  // 랭킹
  static const String ranking = '/ranking';

  // 기록
  static const String record = '/record';

  // 프로필
  static const String profile = '/profile';
  static const String recordDetail = '/recordDetail';
  static const String statistic = '/statistic';

  // Test
  static const String mapTest = 'mapTest';
}
