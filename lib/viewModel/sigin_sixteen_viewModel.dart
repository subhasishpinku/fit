import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aifitness/utils/routes/routes_names.dart';

class SigninSixteenViewModel extends ChangeNotifier {
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  final List<String> options = [
    "Omnivore (Eats plants and animals)",
    "Vegetarian (Includes egg and dairy)",
    // "Vegan (No animal products)",
  ];

  final List<bool> _isVisible = [false, false, false];
  List<bool> get isVisible => _isVisible;

  SigninSixteenViewModel() {
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

  /// Handle selection and save to SharedPreferences
  Future<void> selectOption(BuildContext context, int index) async {
    _selectedIndex = index;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();

    String selectedValue = "";
    if (index == 0) {
      selectedValue = "Non Veg";
    } else if (index == 1) {
      selectedValue = "Veg";
    } else if (index == 2) {
      selectedValue = "Vegan";
    }

    await prefs.setString('meal_type', selectedValue);

    final savedValue = prefs.getString('meal_type');
    print('meal_type: $savedValue');

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: ${options[index]}")));
  }

  /// Navigate to next screen
  void onNextPressed(BuildContext context) {
    if (_selectedIndex != -1) {
      Navigator.pushNamed(context, RouteNames.signinScreenSeventeen);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Please select an option first")),
      // );
    }
  }
}
