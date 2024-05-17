interface class TimeFormatHelper {
  static String formatMilliseconds(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    seconds = seconds % 60;
    return minutes == 0 ? '$seconds초' : '$minutes분 $seconds초';
  }
}
