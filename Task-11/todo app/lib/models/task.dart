import 'package:flutter/material.dart';

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime taskDate;
  final TimeOfDay taskTime;
  final bool isCompleted;
  final bool isArchived;

  Task({
    this.id,
    required this.title,
    this.description = '',
    required this.taskDate,
    required this.taskTime,
    this.isCompleted = false,
    this.isArchived = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'taskDate': taskDate.toIso8601String(),
      'taskTime': '${taskTime.hour}:${taskTime.minute}',
      'isCompleted': isCompleted ? 1 : 0,
      'isArchived': isArchived ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    final timeParts = map['taskTime'].split(':');
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      taskDate: DateTime.parse(map['taskDate']),
      taskTime: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      isCompleted: map['isCompleted'] == 1,
      isArchived: map['isArchived'] == 1,
    );
  }
}