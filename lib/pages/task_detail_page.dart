import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final String task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task),
      ),
      body: Center(
        child: Text('Details for $task'),
      ),
    );
  }
}

