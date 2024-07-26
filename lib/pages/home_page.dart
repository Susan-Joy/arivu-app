import 'package:flutter/material.dart';
import 'task_list_page.dart'; // Import the task list page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskListPage()),
            );
          },
          child: Text('Go to Task List'),
        ),
      ),
    );
  }
}
