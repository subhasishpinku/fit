import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class SigninEightViewModel extends ChangeNotifier {
//   // Generate weight list (40.0 → 120.0 kg with 0.1 step)
//   final List<double> weights = List.generate(
//     801,
//     (index) => 40.0 + index * 0.1,
//   );

//   double _selectedWeight = 70.0; // Default weight
//   double get selectedWeight => _selectedWeight;

//   Future<void> setSelectedWeight(double value) async {
//     _selectedWeight = value;
//     notifyListeners();

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('weight_value', value.toString());

//     final savedYear = prefs.getString('weight_value');
//     print('Saved weight_value: $savedYear');
//   }

  
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninEightViewModel extends ChangeNotifier {
  // Generate weight list (40.0 → 120.0 kg with 0.1 step)
  final List<double> weights = List.generate(
    801,
    (index) => 40.0 + index * 0.1,
  );

  double _selectedWeight = 70.0; // Default weight
  double get selectedWeight => _selectedWeight;
  
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  SigninEightViewModel() {
    _loadSavedWeight();
  }

  Future<void> _loadSavedWeight() async {
    final prefs = await SharedPreferences.getInstance();
    final savedWeight = prefs.getString('weight_value');
    
    if (savedWeight != null) {
      _selectedWeight = double.parse(savedWeight);
      print('Loaded saved weight_value: $savedWeight');
    } else {
      print('No saved weight found, using default: 70.0');
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setSelectedWeight(double value) async {
    _selectedWeight = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weight_value', value.toString());
    print('Saved weight_value: $value');
  }
}