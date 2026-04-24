import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aifitness/utils/routes/routes_names.dart';

class SigninFifteenViewModel extends ChangeNotifier {
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  final List<String> options = [
    "Gym",
    "Home (Dumbbell, Barbell, Band)",
    "Home (Bodyweight)",
  ];

  final List<bool> _isVisible = [false, false, false];
  List<bool> get isVisible => _isVisible;

  SigninFifteenViewModel() {
    _animateButtonsSequentially();
  }

  /// Animate the appearance of buttons one by one
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

    String selectedValue = "";
    if (index == 0) {
      selectedValue = "Gym";
    } else if (index == 1) {
      // selectedValue = "Home (With Limited Gym Equipments)"; 
      selectedValue = "Home (With Limited Gym Equipments)";
    } else if (index == 2) {
      selectedValue = "Home (Bodyweight)";
    }

    await prefs.setString('wo_mode', selectedValue);

    final savedValue = prefs.getString('wo_mode');
    print('wo_mode: $savedValue');

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Selected: ${options[index]}")));
  }

  /// Handle navigation on selection
  void onNextPressed(BuildContext context) {
    if (_selectedIndex != -1) {
      Navigator.pushNamed(context, RouteNames.signinScreenSixteen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an option first")),
      );
    }
  }
}
