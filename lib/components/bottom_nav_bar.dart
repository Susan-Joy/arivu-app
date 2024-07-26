import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int) onTabChange;

  BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: GNav(
        haptic: true,
        color: Colors.grey[400],
        activeColor: Colors.grey[700],
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        onTabChange: (value) => onTabChange(value),
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.dashboard_rounded,
            text: 'Lessons',
          ),
          GButton(
            icon: Icons.chat_bubble_rounded,
            text: 'Chat',
          ),
          GButton(
            icon: Icons.notifications_active_rounded,
            text: 'Notifications',
          ),
          GButton(
            icon: Icons.people_outline_rounded,
            text: 'Community',
          ),
        ],
      ),
    );
  }
}
