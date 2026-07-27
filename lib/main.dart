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

class _ArcHomeState extends State<ArcHome> {
  final List<Session> _sessions = [
    Session(
      title: 'Kalaripayattu practice',
      start: const TimeOfDay(hour: 6, minute: 0),
      end: const TimeOfDay(hour: 7, minute: 0),
    ),
    Session(
      title: 'GATE EC — Network Theorems',
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

  // getters
  int get _completedCount => _sessions.where((t) => t.completed).length;
  int get _totalCount => _sessions.length;
  double get fractionValue =>
      _totalCount > 0 ? _completedCount / _totalCount : 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arc')),
      body: Column(
        children: [
          const SizedBox(height: 24),
          SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: fractionValue,
                  strokeWidth: 10,
                  color: Colors.green,
                  backgroundColor: Colors.grey.shade300,
                ),
                Text(
                  '$_completedCount/$_totalCount',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
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
