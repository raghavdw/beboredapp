class SessionState {
  int completedSessions;
  int totalSessions;

  SessionState({this.completedSessions = 0, this.totalSessions = 3});

  bool isSessionComplete() {
    return completedSessions >= totalSessions;
  }
}
