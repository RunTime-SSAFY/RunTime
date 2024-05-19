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
      case 'userMode':
        return 'CUSTOM';
      case 'practiceMode':
        return 'PRACTICE';
      default:
        return 'BATTLE';
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
