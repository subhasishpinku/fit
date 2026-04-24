import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninFourthViewModel extends ChangeNotifier {
  final List<String> _topics = [
    "Sedentary: Little to no \n physical activity.",
    "Lightly Active: Light exercise or \n physical activity 1–3 days a week.",
    "Moderately Active: Engaging in \n moderate exercise or physical \n activity 3–5 days a week.",
    "Very Active: Hard exercise or \n physical activity 6–7 days a week.",
    "Super Active: Very intense exercise \n or physical activity, often multiple \n times per day, or for those with \n physically demanding jobs or \n training programs.",
  ];

  List<String> get topics => _topics;

  final List<bool> _isVisible = List.filled(5, false);
  List<bool> get isVisible => _isVisible;

  String? _selectedTopic;
  String? get selectedTopic => _selectedTopic;

  SigninFourthViewModel() {
    _animateButtonsSequentially();
  }

  /// Animate button appearance one by one
  Future<void> _animateButtonsSequentially() async {
    for (int i = 0; i < _topics.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      _isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle topic selection & store in SharedPreferences
  Future<void> onTopicSelected(BuildContext context, String topic) async {
    _selectedTopic = topic;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String activityLevel = '';

    if (topic == "Sedentary: Little to no \n physical activity.") {
      activityLevel = 'Sedentary Exercise';
    } else if (topic ==
        "Lightly Active: Light exercise or \n physical activity 1–3 days a week.") {
      activityLevel = 'Light Exercise';
    } else if (topic ==
        "Moderately Active: Engaging in \n moderate exercise or physical \n activity 3–5 days a week.") {
      activityLevel = 'Moderate Exercise';
    } else if (topic ==
        "Very Active: Hard exercise or \n physical activity 6–7 days a week.") {
      activityLevel = 'Intense Exercise';
    } else if (topic ==
        "Super Active: Very intense exercise \n or physical activity, often multiple \n times per day, or for those with \n physically demanding jobs or \n training programs.") {
      activityLevel = 'Super Intense Exercise';
    }

    // Use consistent lowercase key naming
    await prefs.setString('activity_level', activityLevel);

    // Optional: ensure it's written immediately
    await prefs.reload();

    final savedActivity = prefs.getString('activity_level');
    debugPrint(' Saved activity_level: $savedActivity');

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: $topic")));

    //  Navigate only after successful save
    Navigator.pushNamed(context, RouteNames.signinScreenFifth);
  }
}
