// week_state.dart
class WeekState {
  static int currentWeek = 1; // Current week the user is on (can be updated based on progress)
  static List<bool> weekUnlocked = [true, false, false, false]; // True if the week is unlocked

  static bool isWeekUnlocked(int week) {
    return weekUnlocked[week - 1];
  }

  static void unlockWeek(int week) {
    if (week <= weekUnlocked.length) {
      weekUnlocked[week - 1] = true;
    }
  }

  static void completeWeek(int week) {
    if (week < weekUnlocked.length) {
      unlockWeek(week + 1); // Unlock the next week after the current one is completed
    }
  }
}
