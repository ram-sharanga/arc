import 'package:arc/models/entry.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ArcApp());
}

class ArcApp extends StatelessWidget {
  const ArcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ArcHome(),
    );
  }
}

class ArcHome extends StatefulWidget {
  const ArcHome({super.key});

  @override
  State<ArcHome> createState() => _ArcHomeState();
}

enum Status { pending, active, missed, completed }

class _ArcHomeState extends State<ArcHome> {
  final List<Session> _sessions = [
    Session(
      title: 'Kalaripayattu practice',
      start: const TimeOfDay(hour: 6, minute: 0),
      end: const TimeOfDay(hour: 7, minute: 0),
    ),
    Session(
      title: 'GATE EC - Network Theorems',
      start: const TimeOfDay(hour: 9, minute: 0),
      end: const TimeOfDay(hour: 11, minute: 0),
      completed: true,
    ),
    Session(
      title: 'Flute practice',
      start: const TimeOfDay(hour: 17, minute: 0),
      end: const TimeOfDay(hour: 17, minute: 30),
    ),
  ];

  Status? _filter;

  int _minutesFromTimeOfDay(TimeOfDay time) => time.hour * 60 + time.minute;

  int get _nowMinutes {
    final now = TimeOfDay.now();
    return now.hour * 60 + now.minute;
  }

  Status _statusOf(Session s) {
    if (s.completed) return Status.completed;

    final startMin = _minutesFromTimeOfDay(s.start);
    final endMin = _minutesFromTimeOfDay(s.end);
    final now = _nowMinutes;

    if (now < startMin) return Status.pending;
    if (now <= endMin) return Status.active;
    return Status.missed;
  }

  int get _completedCount => _sessions.where((s) => s.completed).length;
  int get _totalCount => _sessions.length;
  double get fractionValue =>
      _totalCount > 0 ? _completedCount / _totalCount : 0.0;

  List<Session> get _filteredSessions {
    // All filter (null) => return full list
    if (_filter == null) return _sessions;

    switch (_filter!) {
      case Status.pending:
        return _sessions.where((s) => _statusOf(s) == Status.pending).toList();
      case Status.active:
        return _sessions.where((s) => _statusOf(s) == Status.active).toList();
      case Status.missed:
        return _sessions.where((s) => _statusOf(s) == Status.missed).toList();
      case Status.completed:
        return _sessions
            .where((s) => _statusOf(s) == Status.completed)
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arc')),
      body: Column(
        children: [
          const SizedBox(height: 24),

          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: fractionValue,
                  strokeWidth: 12,
                  color: Colors.green,
                  backgroundColor: Colors.grey.shade300,
                ),
                Text(
                  '$_completedCount/$_totalCount',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<Status?>(
              segments: const [
                ButtonSegment(value: null, label: Text('All')),
                ButtonSegment(value: Status.pending, label: Text('Pending')),
                ButtonSegment(value: Status.active, label: Text('Live')),
                ButtonSegment(value: Status.missed, label: Text('Missed')),
                ButtonSegment(value: Status.completed, label: Text('Forged')),
              ],
              selected: {_filter},
              onSelectionChanged: (Set<Status?> newSelection) {
                setState(() {
                  _filter = newSelection.first;
                });
              },
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              itemCount: _filteredSessions.length,
              itemBuilder: (context, index) {
                final session = _filteredSessions[index];
                return ListTile(
                  leading: Checkbox(
                    value: session.completed,
                    onChanged: (_) {
                      setState(() {
                        session.completed = !session.completed;
                      });
                    },
                  ),
                  title: Text(
                    session.title,
                    style: session.completed
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                          )
                        : null,
                  ),
                  subtitle: Text(
                    '${session.start.format(context)} – ${session.end.format(context)}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
