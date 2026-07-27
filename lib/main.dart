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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arc')),
      body: ListView.builder(
        itemCount: _sessions.length,
        itemBuilder: (context, index) {
          final session = _sessions[index];
          return ListTile(
            title: Text(session.title),
            subtitle: Text(
              '${session.start.format(context)} – ${session.end.format(context)}',
            ),
          );
        },
      ),
    );
  }
}
