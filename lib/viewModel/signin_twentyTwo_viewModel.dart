import 'dart:convert';

import 'package:aifitness/models/food_model.dart';
import 'package:aifitness/repository/food_repository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninTwentyTwoViewModel extends ChangeNotifier {
  final FoodRepository _repo = FoodRepository();

  List<FoodModel> foods = [];
  bool isLoading = false;
  String errorMessage = "";
  String? mealType = "";

  /// ==================== Fetch foods from API ======================
  Future<void> fetchFoods() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    mealType = prefs.getString("meal_type");

    try {
      foods = await _repo.getFoods(
        classification: "Nut",
        type: mealType!,
        search: "",
      );
    print("meal_type $mealType");
      if (foods.isEmpty) {
        errorMessage = "No foods found.";
      }
    } catch (e) {
      errorMessage = "Failed to load foods.";
    }

    isLoading = false;
    notifyListeners();
  }

  /// ==================== Selection Logic ======================
  final List<String> _selectedItems = [];

  List<String> get selectedItems => _selectedItems;

  bool get canProceed =>
      _selectedItems.length >= 2 && _selectedItems.length <= 5;

  void toggleSelection(FoodModel item) {
    final String value = item.name; // Save item.name

    if (_selectedItems.contains(value)) {
      _selectedItems.remove(value);
    } else {
      if (_selectedItems.length < 5) {
        _selectedItems.add(value);
      }
    }
    notifyListeners();
  }

  /// ==================== Save Selected Items ======================
  Future<void> saveSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(_selectedItems);
    await prefs.setString("nut", jsonString);
    String? grainsString = prefs.getString("nut");

    print("Saved nut: $grainsString");
  }

  void onNextPressed(BuildContext context) {
    if (canProceed) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("Proceeding to next step..."),
      //     duration: Duration(seconds: 1),
      //   ),
      // );
      saveSelectedItems();
      // TODO: Update with your next screen route
      Navigator.pushNamed(context, RouteNames.signinScreenTwentyThree);
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text("Please select between 2 and 5 items."),
      //     duration: Duration(seconds: 2),
      //   ),
      // );
    }
  }
}
