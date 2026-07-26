enum SessionStatus { live, settled, missed }

class Session {
  final int number;
  final String title;
  final String time;
  final SessionStatus status;

  Session({
    required this.number,
    required this.title,
    required this.time,
    required this.status,
  });
}
