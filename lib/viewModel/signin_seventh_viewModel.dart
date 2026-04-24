import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninSeventhViewModel extends ChangeNotifier {
  int _selectedHeight = 160; // default height in cm
  final List<int> _heights = List.generate(101, (i) => 100 + i); // 100–200 cm

  int get selectedHeight => _selectedHeight;
  List<int> get heights => _heights;

  Future<void> setSelectedHeight(int height) async {
    _selectedHeight = height;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('height_value', height.toString());

    final savedYear = prefs.getString('height_value');
    print('Saved height_value: $savedYear');
  }
}
