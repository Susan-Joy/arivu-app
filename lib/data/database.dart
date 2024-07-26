import 'package:hive_flutter/hive_flutter.dart';

class ToDataBase {
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    _myBox.put('name', 'Guest');
    _myBox.put('age', 0);
    _myBox.put('isOnboardingComplete', false);
  }

  void updateDataBase(String name, int age) {
    _myBox.put('name', name);
    _myBox.put('age', age);
  }

  String getName() {
    return _myBox.get('name', defaultValue: 'Guest');
  }

  int getAge() {
    return _myBox.get('age', defaultValue: 0);
  }

  bool isOnboardingComplete() {
    return _myBox.get('isOnboardingComplete', defaultValue: false);
  }

  void setOnboardingComplete(bool value) {
    _myBox.put('isOnboardingComplete', value);
  }
}

