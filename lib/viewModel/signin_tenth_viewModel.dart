import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninTenthViewModel extends ChangeNotifier {
  final List<int> _waistMeasurements = List.generate(50, (index) => 55 + index);
  int _selectedWaist = 60;

  List<int> get waistMeasurements => _waistMeasurements;
  int get selectedWaist => _selectedWaist;

  Future<void> setSelectedWaist(int newWaist) async {
    _selectedWaist = newWaist;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('waist', newWaist.toString());

    final savedwaist = prefs.getString('waist');
    print('Saved savedwaist: $savedwaist');
  }
}
