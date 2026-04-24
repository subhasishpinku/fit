import 'package:aifitness/models/FoodItem.dart';

class DietData {
  List<FoodItem>? breakfast;
  List<FoodItem>? lunch;
  List<FoodItem>? dinner;
  List<FoodItem>? snacks;
  List<FoodItem>? preWorkout;
  List<FoodItem>? postWorkout;
  List<FoodItem>? supplements; // Add this line

  /// Alternative foods
  List<FoodItem>? breakfastAlternative;
  List<FoodItem>? lunchAlternative;
  List<FoodItem>? dinnerAlternative;
  List<FoodItem>? snackAlternative;

  String? check;
  TargetCalories? targetCalories;
  MealWise? mealWise;
  UserTargetsPercentage? userTargetsPercentage;

  DietData.fromJson(Map<String, dynamic> json) {
    breakfast = _parseList(json['breakfast']);
    lunch = _parseList(json['lunch']);
    dinner = _parseList(json['dinner']);
    snacks = _parseList(json['snacks']);
    preWorkout = _parseList(json['pre_workout']);
    postWorkout = _parseList(json['post_workout']);
    supplements = _parseList(json['supplements']); // Add this line

    /// Alternative foods parsing
    breakfastAlternative = _parseList(json['breakfast_alternative']);
    lunchAlternative = _parseList(json['lunch_alternative']);
    dinnerAlternative = _parseList(json['dinner_alternative']);
    snackAlternative = _parseList(json['snack_alternative']);

    check = json['check'];

    targetCalories = json['target_calories'] != null
        ? TargetCalories.fromJson(json['target_calories'])
        : null;

    mealWise = json['meal_wise'] != null
        ? MealWise.fromJson(json['meal_wise'])
        : null;

    userTargetsPercentage = json['user_targets_percentage'] != null
        ? UserTargetsPercentage.fromJson(json['user_targets_percentage'])
        : null;
  }

  List<FoodItem> _parseList(dynamic data) {
    if (data == null) return [];
    return (data as List).map((e) => FoodItem.fromJson(e)).toList();
  }
}

class TargetCalories {
  String? breakfast;
  String? lunch;
  String? dinner;
  String? snacks;
  String? totalCalories;
  String? proteinCaloriesPercentage;
  String? fatCaloriesPercentage;
  String? carbsCaloriesPercentage;

  TargetCalories.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'];
    lunch = json['lunch'];
    dinner = json['dinner'];
    snacks = json['snacks'];
    totalCalories = json['total_calories'];
    proteinCaloriesPercentage = json['protein_calories_percentage'];
    fatCaloriesPercentage = json['fat_calories_percentage'];
    carbsCaloriesPercentage = json['carbs_calories_percentage'];
  }
}

class MealWise {
  MealTotals? breakfast;
  MealTotals? lunch;
  MealTotals? dinner;
  MealTotals? snacks;
  MealTotals? postWorkout;
  MealTotals? preWorkout;

  MealWise.fromJson(Map<String, dynamic> json) {
    breakfast = _parse(json['breakfast']);
    lunch = _parse(json['lunch']);
    dinner = _parse(json['dinner']);
    snacks = _parse(json['snacks']);
    postWorkout = _parse(json['post_workout']);
    preWorkout = _parse(json['pre_workout']);
  }

  MealTotals? _parse(dynamic json) =>
      json != null ? MealTotals.fromJson(json) : null;
}

class MealTotals {
  String? targetCalories;
  String? proteinTotal;
  String? fatTotal;
  String? carbsTotal;
  String? lysineTotal;
  String? fiberTotal;

  MealTotals.fromJson(Map<String, dynamic> json) {
    targetCalories = json['target_calories'];
    proteinTotal = json['protein_total'];
    fatTotal = json['fat_total'];
    carbsTotal = json['carbs_total'];
    lysineTotal = json['lysine_total'];
    fiberTotal = json['fiber_total'];
  }
}

class UserTargetsPercentage {
  MacroPercent? breakfast;
  MacroPercent? lunch;
  MacroPercent? dinner;
  MacroPercent? snacks;
  MacroPercent? preWorkout;
  MacroPercent? postWorkout;

  UserTargetsPercentage.fromJson(Map<String, dynamic> json) {
    breakfast = _p(json['Breakfast']);
    lunch = _p(json['Lunch']);
    dinner = _p(json['Dinner']);
    snacks = _p(json['Snacks']);
    preWorkout = _p(json['Pre Workout']);
    postWorkout = _p(json['Post Workout']);
  }

  MacroPercent? _p(dynamic json) =>
      json != null ? MacroPercent.fromJson(json) : null;
}

class MacroPercent {
  int? carbs;
  int? protein;
  int? fat;

  MacroPercent.fromJson(Map<String, dynamic> json) {
    carbs = json['carbs'];
    protein = json['protein'];
    fat = json['fat'];
  }
}
