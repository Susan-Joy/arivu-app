import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:arivu/data/database.dart'; // Import your database
import 'package:arivu/pages/home_page.dart'; // Import your home page
import 'package:arivu/pages/onboarding_form_page.dart'; // Import your onboarding form page
import 'package:arivu/pages/dashboard_page.dart'; // Import your dashboard page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('mybox');

  final db = ToDataBase();
  final isOnboardingComplete = db.isOnboardingComplete();

  runApp(MyApp(isOnboardingComplete: isOnboardingComplete));
}

class MyApp extends StatelessWidget {
  final bool isOnboardingComplete;

  MyApp({required this.isOnboardingComplete});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isOnboardingComplete ? DashboardPage() : OnboardingFormPage(),
    );
  }
}

