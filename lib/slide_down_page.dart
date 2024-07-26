// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:arivu/pages/task_detail_page.dart';

class SlideDownPage extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide Down Page'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              tileColor: Colors.blueAccent.withOpacity(0.1),
              title: Text(items[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetailPage(task: items[index]),
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