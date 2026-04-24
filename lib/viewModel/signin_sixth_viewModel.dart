import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninSixthViewModel extends ChangeNotifier {
  // Default to 25 years old if not chosen
  // int _selectedYear = DateTime.now().year - 25;
  int _selectedYear = 1990;
  final List<int> _years = List.generate(60, (i) => 1950 + i);

  int get selectedYear => _selectedYear;
  List<int> get years => _years;

  /// Save selected year (DOB year) to SharedPreferences
  Future<void> setSelectedYear(int year) async {
    _selectedYear = year;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('dob_age_year', year.toString());

      final savedYear = prefs.getString('dob_age_year');
      debugPrint(' Saved dob_age_year: $savedYear');
    } catch (e) {
      debugPrint('Error saving dob_age_year: $e');
    }
  }

  /// Load saved year (if available) — optional helper
  Future<void> loadSavedYear() async {
    final prefs = await SharedPreferences.getInstance();
    final savedYear = prefs.getString('dob_age_year');
    if (savedYear != null) {
      _selectedYear = int.tryParse(savedYear) ?? _selectedYear;
      notifyListeners();
      debugPrint('Loaded saved dob_age_year: $_selectedYear');
    }
  }
}
