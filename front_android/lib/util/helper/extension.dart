extension DurationFormatter on Duration {
  String toHhMmSs() {
    String hours = inHours.toString().padLeft(2, '0');
    String minutes = (inMinutes % 60).toString().padLeft(2, '0');
    String seconds =
        (inSeconds % 60).toString().padLeft(2, '0'); // Only use seconds portion
    return '$hours:$minutes:$seconds';
  }
}

extension DoubleExtension on double {
  String toKilometer() {
    return '${(this / 1000).toStringAsFixed(2)}km';
  }
}
