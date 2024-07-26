import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:arivu/data/database.dart';
import 'package:arivu/pages/landing.dart';
import 'onboarding_page.dart'; // Correct import for your onboarding page

class OnboardingFormPage extends StatefulWidget {
  @override
  _OnboardingFormPageState createState() => _OnboardingFormPageState();
}

class _OnboardingFormPageState extends State<OnboardingFormPage> {
  final ToDataBase db = ToDataBase();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // No need to load data here since we handle it directly in the methods
  }

  Future<void> _submitForm(BuildContext context) async {
    final String name = _nameController.text.trim();
    final String ageStr = _ageController.text.trim();

    if (name.isNotEmpty && ageStr.isNotEmpty) {
      final int age = int.tryParse(ageStr) ?? 0;
      db.updateDataBase(name, age);
      db.setOnboardingComplete(true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OnboardingPage()), // Navigate to OnboardingPage
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create Your Account',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('mybox');

  final db = ToDataBase();
  final isOnboardingComplete = db.isOnboardingComplete();

  runApp(MaterialApp(
    home: isOnboardingComplete ? Landing() : OnboardingFormPage(),
  ));
}
