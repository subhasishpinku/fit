import 'dart:convert';
import 'package:aifitness/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMealViewModel extends ChangeNotifier {
  Map<String, List<String>> meals = {
    "breakfast": [],
    "lunch": [],
    "snack": [],
    "dinner": [],
  };

  Future<void> loadMeals() async {
    final prefs = await SharedPreferences.getInstance();

    meals["breakfast"] = List<String>.from(
      jsonDecode(prefs.getString("breakfast_food_items_past") ?? "[]"),
    );

    meals["lunch"] = List<String>.from(
      jsonDecode(prefs.getString("lunch_food_items_past") ?? "[]"),
    );

    meals["snack"] = List<String>.from(
      jsonDecode(prefs.getString("snack_food_items_past") ?? "[]"),
    );

    meals["dinner"] = List<String>.from(
      jsonDecode(prefs.getString("dinner_food_items_past") ?? "[]"),
    );

    notifyListeners();
  }

  Future<void> addMeal(String type, String meal) async {
    final prefs = await SharedPreferences.getInstance();

    meals[type]?.add(meal);

    await prefs.setString("${type}_food_items_past", jsonEncode(meals[type]));
    getMeals(type).then((value) => print("Meals for $type: $value"));
    notifyListeners();
  }

  Future<List<String>> getMeals(String type) async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("${type}_food_items_past");

    if (data != null) {
      return List<String>.from(jsonDecode(data));
    }

    return [];
  }

  Future<void> removeMeal(String type, int index) async {
    final prefs = await SharedPreferences.getInstance();

    meals[type]?.removeAt(index);

    await prefs.setString("${type}_food_items_past", jsonEncode(meals[type]));

    notifyListeners();
  }

  Future<void> onNextPressed(BuildContext context) async {
    Navigator.pushNamed(context, RouteNames.signinScreenTwentyFour);
  }
}
