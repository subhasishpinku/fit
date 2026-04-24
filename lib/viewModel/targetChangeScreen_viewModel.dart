import 'package:flutter/material.dart';

class TargetChangeScreenViewModel extends ChangeNotifier {
  String weight = "60KG";
  String goal = "9% body fat (Target: 48.40 kg)";
  String weightToLose = "20.4 kg";

  String pace = "0.5 kg/week";
  String timeToGoal = "82 weeks";

  final List<Map<String, String>> milestones = [
    {
      "title": "Milestone 1 (Active)",
      "targetWeight": "49.8 kg",
      "calories": "1351 kcal (down from 1604.1 kcal)",
      "time": "~41 weeks",
    },
    {
      "title": "Milestone 2",
      "targetWeight": "48.4 kg",
      "calories": "1300 kcal (down from 1351.4 kcal)",
      "time": "~41 weeks",
    },
  ];

  void changeDetails() {
    // Add logic for navigation or editing here
    notifyListeners();
  }
}
