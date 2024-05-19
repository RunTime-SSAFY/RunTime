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
    final kilometer = this / 1000;
    String formattedString = kilometer.toStringAsFixed(2);
    final decimal = formattedString.split('.')[1];
    if (decimal == '00') {
      return '${formattedString[0]}km';
    } else if (decimal.endsWith('0')) {
      return '${kilometer.toStringAsFixed(1)}km';
    }
    return '${kilometer.toStringAsFixed(2)}km';
  }
}
