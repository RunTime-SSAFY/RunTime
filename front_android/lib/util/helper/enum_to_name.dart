interface class EnumToName {
  static String getGameMode(String gameMode) {
    switch (gameMode) {
      case "BATTLE":
        return "대결모드";
      case "CUSTOM":
        return "사용자모드";
      case "PRACTICE":
        return "연습모드";
      default:
        return "잘 못된 게임 모드";
    }
  }
}
