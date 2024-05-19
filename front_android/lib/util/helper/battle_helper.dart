interface class DestinationHelper {
  static String getForSend(String type, String uuid) => '/pub/$type/$uuid';
  static String getForSub(String type, String uuid) => '/topic/$type/$uuid';

  static String getStartMatching(String userId) => '/queue/member/$userId';
  static String getMatchingReady(String uuid) => '/topic/matchingRoom/$uuid';
}

interface class BattleModeHelper {
  static String get matching => 'matchingRoom';
  static String get userMode => 'room';
  static String get practiceMode => 'practice';

  static String getModeName(String mode) {
    switch (mode) {
      case 'room':
        return 'CUSTOM';
      case 'practice':
        return 'PRACTICE';
      default:
        return 'BATTLE';
    }
  }

  static String getRankingReceive(String mode) {
    switch (mode) {
      case 'matchingRoom':
        return 'matchings';
      case 'room':
        return 'rooms';
      default:
        return 'matchings';
    }
  }
}

interface class ActionHelper {
  static get matchingStartAction => 'matching';
  static get battleStartAction => 'start';
  static get battleRejectedAction => 'notstart';
  static get battleGiveUpAction => 'exit';
  static get roomInforAction => 'member';
  static get battleRealTimeAction => 'realtime';
}
