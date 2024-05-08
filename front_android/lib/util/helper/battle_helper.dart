interface class DestinationHelper {
  static String _getForSend(String type, int roomId) => '/pub/$type/$roomId';
  static String getForSub(String type, int roomId) => '/topic/$type/$roomId';

  static String getBattleDestination(String mode, int roomId) {
    if (mode == BattleModeHelper.practiceMode) {
      return _getForSend('matchingRoom', roomId);
    }
    if (mode == BattleModeHelper.userMode) {
      return _getForSend('room', roomId);
    } else {
      return _getForSend('practice', roomId);
    }
  }

  static String getStartMatching(String userId) => '/queue/member/$userId';
}

interface class BattleModeHelper {
  static String get matching => 'matching';
  static String get userMode => 'userMode';
  static String get practiceMode => 'practiceMode';
}

interface class ActionHelper {
  static get matchingStartAction => 'matching';
  static get battleStartAction => 'start';
  static get battleRejectedAction => 'notstart';
  static get battleGiveUpAction => 'exit';
  static get roomInforAction => 'member';
}
