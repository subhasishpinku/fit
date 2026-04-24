import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninThirdViewModel extends ChangeNotifier {
  final List<String> _topics = [
    "Safe (0.25 kg/week)",
    "Moderate (0.5 kg/week)",
    "Aggressive (0.75 kg/week)",
  ];

  List<String> get topics => _topics;

  // For animation visibility
  final List<bool> _isVisible = [false, false, false];
  List<bool> get isVisible => _isVisible;

  String? _selectedTopic;
  String? get selectedTopic => _selectedTopic;

  SigninThirdViewModel() {
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

    // Use consistent lowercase snake_case key
    String howFast = '';

    if (topic == "Safe (0.25 kg/week)") {
      howFast = 'easy';
    } else if (topic == "Moderate (0.5 kg/week)") {
      howFast = 'normal';
    } else if (topic == "Aggressive (0.75 kg/week)") {
      howFast = 'challenge';
    }

    //  Save safely
    await prefs.setString('how_fast_to_reach_goal', howFast);

    //  Optional: reload from disk to ensure data sync
    await prefs.reload();

    //  Verify saved value
    final savedValue = prefs.getString('how_fast_to_reach_goal');
    debugPrint(' Saved how_fast_to_reach_goal: $savedValue');

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text("Selected: $topic")),
    // );

    //  Navigate after successful save
    Navigator.pushNamed(context, RouteNames.signinScreenFourth);
  }
}
