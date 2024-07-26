import 'package:arivu/components/bottom_nav_bar.dart';
import 'package:arivu/pages/chat_page.dart';
import 'package:arivu/pages/community_page.dart';
import 'package:arivu/pages/lessons_page.dart';
import 'package:arivu/pages/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:arivu/data/database.dart';

class Landing extends StatefulWidget {
  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    LessonsPage(),
    ChatPage(),
    NotificationsPage(),
    CommunityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final db = ToDataBase();
    final name = db.getName();
    final age = db.getAge();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: _pages[_selectedIndex],
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNavBar(
        onTabChange: navigateBottomBar,
      ),
    );
  }
}
