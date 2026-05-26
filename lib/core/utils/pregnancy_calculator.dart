class PregnancyCalculator {
  PregnancyCalculator._();

  /// Returns the current week of pregnancy (1-40) based on LMP date.
  static int currentWeek(DateTime lmpDate) {
    final now = DateTime.now();
    final diff = now.difference(lmpDate).inDays;
    final week = (diff / 7).floor() + 1;
    return week.clamp(1, 40);
  }

  /// Returns days remaining until due date (LMP + 280 days).
  static int daysRemaining(DateTime lmpDate) {
    final dueDate = lmpDate.add(const Duration(days: 280));
    final now = DateTime.now();
    final remaining = dueDate.difference(now).inDays;
    return remaining.clamp(0, 280);
  }

  /// Calculates due date from LMP.
  static DateTime dueDate(DateTime lmpDate) =>
      lmpDate.add(const Duration(days: 280));

  /// Returns the trimester number (1, 2, or 3) for a given week.
  static int trimester(int week) {
    if (week <= 13) return 1;
    if (week <= 26) return 2;
    return 3;
  }

  /// Returns the trimester label.
  static String trimesterLabel(int week) {
    switch (trimester(week)) {
      case 1: return 'First Trimester';
      case 2: return 'Second Trimester';
      default: return 'Third Trimester';
    }
  }

  /// Progress within the current trimester (0.0 - 1.0).
  static double trimesterProgress(int week) {
    if (week <= 13) return week / 13;
    if (week <= 26) return (week - 13) / 13;
    return (week - 26) / 14;
  }

  /// Overall pregnancy progress (0.0 - 1.0).
  static double overallProgress(int week) => week / 40;

  /// Returns pregnancy week from a DateTime lmpDate string (ISO format).
  static int weekFromIso(String isoDate) {
    try {
      return currentWeek(DateTime.parse(isoDate));
    } catch (_) {
      return 1;
    }
  }

  /// Returns the LMP date from a due date.
  static DateTime lmpFromDueDate(DateTime dueDate) =>
      dueDate.subtract(const Duration(days: 280));
}
