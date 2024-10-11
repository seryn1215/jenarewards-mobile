class DateUtil {
  static String formatDate(DateTime date) {
    return "${_twoDigits(date.day)}/${_twoDigits(date.month)}/${date.year}";
  }

  static DateTime parseDate(String date) {
    var parts = date.split('/');
    return DateTime(
        int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  static String formatTime(DateTime date) {
    return "${_twoDigits(date.hour)}:${_twoDigits(date.minute)}";
  }

  static String formatDateTime(DateTime date) {
    return "${formatDate(date)} ${formatTime(date)}";
  }

  static String _twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }
}
