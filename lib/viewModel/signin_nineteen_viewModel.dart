import 'dart:convert';

import 'package:aifitness/models/food_model.dart';
import 'package:aifitness/repository/food_repository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninNineteenViewModel extends ChangeNotifier {
  final FoodRepository _repo = FoodRepository();

  List<FoodModel> foods = [];
  bool isLoading = false;
  String errorMessage = "";
  String? mealType = "";

  /// ==================== Fetch foods from API ======================
  Future<void> fetchFoods() async {
    isLoading = true;
    errorMessage = "";
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    mealType = prefs.getString("meal_type");

    try {
      foods = await _repo.getFoods(
        classification: "Protein",
        type: mealType!,
        search: "",
      );

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

  // void toggleSelection(String item) {
  //   if (_selectedItems.contains(item)) {
  //     _selectedItems.remove(item);
  //   } else {
  //     if (_selectedItems.length < 5) {
  //       _selectedItems.add(item);
  //     }
  //   }
  //   notifyListeners();
  // }
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
  /// ==================== Save Selected Items to SharedPreferences ======================
  Future<void> saveSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();

    // Convert List<String> → JSON String
    String jsonString = jsonEncode(_selectedItems);

    await prefs.setString("proteins", jsonString);
    String? grainsString = prefs.getString("proteins");
    print("Saved proteins String: $grainsString"); // prints JSON string
  }

  /// ==================== Next Button ======================
  void onNextPressed(BuildContext context) async {
    if (canProceed) {
      await saveSelectedItems(); // SAVE THE LIST BEFORE NAVIGATION

      Navigator.pushNamed(context, RouteNames.signinScreenTwenty);
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
