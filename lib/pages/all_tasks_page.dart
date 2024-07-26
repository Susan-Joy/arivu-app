import 'package:flutter/material.dart';
import 'task_detail_page.dart'; // Import the detail page

class AllTasksPage extends StatelessWidget {
  final List<String> tasks = List.generate(10, (index) => 'Task ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tasks'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: Colors.blueAccent.withOpacity(0.1),
              title: Text(tasks[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailPage(task: tasks[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
