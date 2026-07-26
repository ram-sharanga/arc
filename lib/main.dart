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
      home: Scaffold(
        appBar: AppBar(title: const Text('Arc')),
        body: const Center(child: Text('Arc')),
      ),
    );
  }
}
