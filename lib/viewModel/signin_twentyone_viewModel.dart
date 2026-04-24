import 'dart:convert';
import 'package:aifitness/models/food_model.dart';
import 'package:aifitness/repository/food_repository.dart';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninTwentyOneViewModel extends ChangeNotifier {
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
        classification: "Fruit",
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

  // void toggleSelection(String fruit) {
  //   if (_selectedItems.contains(fruit)) {
  //     _selectedItems.remove(fruit);
  //   } else {
  //     if (_selectedItems.length < 5) {
  //       _selectedItems.add(fruit);
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

  /// ==================== Save Selected Items ======================
  Future<void> saveSelectedItems() async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(_selectedItems);
    await prefs.setString("fruit", jsonString);

    print("Saved fruit: $jsonString");
  }

  /// ==================== Next Button ======================
  void onNextPressed(BuildContext context) async {
    if (!canProceed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select between 2 and 5 items.")),
      );
      return;
    }

    await saveSelectedItems();

    // Navigator.pushNamed(context, RouteNames.signinScreenTwentyTwo);
          Navigator.pushNamed(context, RouteNames.signinScreenTwentyThree);

  }
}
