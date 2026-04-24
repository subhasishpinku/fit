import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninNinthViewModel extends ChangeNotifier {
  final List<int> _hipMeasurements = List.generate(50, (index) => 60 + index);
  int _selectedHip = 90;

  List<int> get hipMeasurements => _hipMeasurements;
  int get selectedHip => _selectedHip;

  Future<void> setSelectedHip(int newHip) async {
    _selectedHip = newHip;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('hip', newHip.toString());

    final savedhip = prefs.getString('hip');
    print('Saved hip: $savedhip');
  }
}
