import 'dart:async';

class SessionState {
  static int sessionMinutes = 5;
  static int sessionSeconds = 0;
  static bool sessionStarted = false;
  static Timer? _timer;

  // Start the session
  static void startSession(Function onComplete) {
    sessionStarted = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (sessionSeconds > 0) {
        sessionSeconds--;
      } else {
        if (sessionMinutes > 0) {
          sessionMinutes--;
          sessionSeconds = 59;
        } else {
          stopSession();
          onComplete(); // Notify that the session is complete
        }
      }
    });
  }

  // Stop the session
  static void stopSession() {
    _timer?.cancel();
    sessionStarted = false;
    sessionMinutes = 5; // Reset to original time
    sessionSeconds = 0;
  }

  // Check if the session is still active
  static bool isSessionActive() {
    return sessionStarted;
  }
}
