interface class DateTimeFormatHelper {
  // 밀리초를 00:00 형식으로 변환
  static String formatMilliseconds(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    seconds = seconds % 60;
    return minutes == 0 ? '$seconds초' : '$minutes분 $seconds초';
  }

  // 2024. 4. 26. 19:20 형식으로 변환
  static String formatDateTime(DateTime dateTime) {
    return '${dateTime.year}. ${dateTime.month}. ${dateTime.day}. ${dateTime.hour}:${dateTime.minute}';
  }
}
