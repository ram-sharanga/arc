import 'package:flutter/material.dart';

class Session {
  final String title;
  final TimeOfDay start;
  final TimeOfDay end;
  bool completed;

  Session({
    required this.title,
    required this.start,
    required this.end,
    this.completed = false,
  });
}