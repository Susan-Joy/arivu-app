import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:arivu/data/database.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = ToDataBase();
    final name = db.getName();
    final age = db.getAge();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Text('Hello, $name. You are $age years old.'),
      ),
    );
  }
}