import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninSecondViewModel extends ChangeNotifier {
  final List<String> _topics = [
    "Strength Training",
    "Cardio Training",
    "Strength & Cardio Training",
  ];

  List<String> get topics => _topics;

  // For button visibility animation
  final List<bool> _isVisible = [false, false, false];
  List<bool> get isVisible => _isVisible;

  String? _selectedTopic;
  String? get selectedTopic => _selectedTopic;

  SigninSecondViewModel() {
    _animateButtonsSequentially();
  }

  /// Sequential animation for button appearance
  Future<void> _animateButtonsSequentially() async {
    for (int i = 0; i < _topics.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      _isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle topic selection
  Future<void> onTopicSelected(BuildContext context, String topic) async {
    _selectedTopic = topic;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    //  Always use lowercase, consistent key naming
    String fitnessGoal = '';

    if (topic == "Strength Training") {
      fitnessGoal = 'Strength';
    } else if (topic == "Cardio Training") {
      fitnessGoal = 'Cardio';
    } else if (topic == "Strength & Cardio Training") {
      fitnessGoal = 'Strength-Cardio';
    }

    // Save value
    await prefs.setString('fitness_goal', fitnessGoal);

    //  Optional safety (forces sync from disk)
    await prefs.reload();

    //  Verify saved value
    final savedGoal = prefs.getString('fitness_goal');
    debugPrint(' Saved fitness_goal: $savedGoal');

    //  Show feedback
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: $topic")));

    // Navigate only after ensuring data is saved
    Navigator.pushNamed(context, RouteNames.signinScreenThird);
  }
}
