class DateFormatter {
  static DateTime thisMonthFirstDay(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime thisMonthLastDay(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }
}
