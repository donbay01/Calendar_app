
import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    required this.to,
    required this.title,
    required this.description,
    required this.from,
     this.backgroundColor = Colors.deepOrange,
     this.isAllDay = false,
  });
}