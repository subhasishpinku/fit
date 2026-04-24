import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninFifthViewModel extends ChangeNotifier {
  final List<String> _topics = ["Male", "Female"];
  List<String> get topics => _topics;

  // Only 2 buttons, so 2 visibility flags
  final List<bool> _isVisible = List.filled(2, false);
  List<bool> get isVisible => _isVisible;

  String? _selectedTopic;
  String? get selectedTopic => _selectedTopic;

  SigninFifthViewModel() {
    _animateButtonsSequentially();
  }

  /// Animate buttons appearing one by one
  Future<void> _animateButtonsSequentially() async {
    for (int i = 0; i < _topics.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      _isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle topic selection (save to SharedPreferences)
  Future<void> onTopicSelected(BuildContext context, String topic) async {
    _selectedTopic = topic;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String gender = '';

    if (topic == "Male") {
      gender = 'M';
    } else if (topic == "Female") {
      gender = 'F';
    }

    //  Save value with consistent lowercase key
    await prefs.setString('gender', gender);

    //  Force reload (optional, ensures persistence)
    await prefs.reload();

    final savedGender = prefs.getString('gender');
    debugPrint(' Saved gender: $savedGender');

    //  User feedback
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: $topic")));

    // Navigate only after data saved
    Navigator.pushNamed(context, RouteNames.signinScreenSixth);
  }
}
