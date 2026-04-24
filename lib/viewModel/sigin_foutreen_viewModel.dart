import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aifitness/utils/routes/routes_names.dart';

class SigninFourteenViewModel extends ChangeNotifier {
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  final List<String> options = [
    "1 Day / Week (6 days rest)",
    "3 Days / Week (Good balance)",
    "6 Days / Week (Only 1 rest day)",
  ];

  final List<bool> _isVisible = [false, false, false];
  List<bool> get isVisible => _isVisible;

  SigninFourteenViewModel() {
    _animateButtonsSequentially();
  }

  /// Animate button appearance one by one
  Future<void> _animateButtonsSequentially() async {
    for (int i = 0; i < options.length; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      _isVisible[i] = true;
      notifyListeners();
    }
  }

  /// Handle option selection
  Future<void> selectOption(BuildContext context, int index) async {
    _selectedIndex = index;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    int selectedValue = 0;
    if (index == 0) {
      selectedValue = 1;
    } else if (index == 1) {
      selectedValue = 3;
    } else if (index == 2) {
      selectedValue = 6;
    }

    ///  Save selectedValue as int
    await prefs.setInt('no_of_days_per_week', selectedValue);

    final savedValue = prefs.getInt('no_of_days_per_week');
    print('Saved No_of_days_per_week: $savedValue');

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: ${options[index]}")));
  }

  /// Navigate to next screen
  void onNextPressed(BuildContext context) {
    if (_selectedIndex != -1) {
      Navigator.pushNamed(context, RouteNames.signinScreenFifteen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an option first")),
      );
    }
  }
}
