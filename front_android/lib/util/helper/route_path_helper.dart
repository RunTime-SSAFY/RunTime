enum RouteParameter {
  targetDistance;
}

interface class RoutePathHelper {
  // 로그인 & 메인
  static const String login = '/login';
  static const String runMain = '/main';

  // 배틀
  static const String battle = '/battle';
  static const String battleResult = '/battleResult';

  // 매칭
  static const String beforeMatching = '/beforeMatching';
  static const String matching = '/matching';
  static const String matched = '/matched';

  // 유저 모드
  static const String userMode = '/userMode';
  static const String waitingRoom = '/waitingRoom/:roomId';
  static String waitingRoomWithId(int roomId) => '/waitingRoom/$roomId';
  static const String userModeSearch = '/userModeSearch';

  // 연습 모드
  static const String practiceMode = '/practiceMode';

  // 랭킹
  static const String ranking = '/ranking';

  // 도전 과제
  static const String achievement = '/achievement';
  static const String achievementReward = '/achievement/reward';

  // 캐릭터
  static const String character = '/character';

  // 기록
  static const String record = '/record';
  static const String recordDetail = '/record/detail';
  static const String statistic = '/record/statistic';

  // 프로필
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';

  // Test
  static const String mapTest = 'mapTest';
}
